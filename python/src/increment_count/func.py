import io
import oci
import json
import logging
from fdk import response


def handler(ctx, data: io.BytesIO = None):

    signer = oci.auth.signers.get_resource_principals_signer()
    logging.getLogger().info("URI: " + ctx.RequestURL())
    print("Entering Python Hello World handler", flush=True)
    name = "World"

    try:
        body = json.loads(data.getvalue())
        name = body.get("name")
    except (Exception, ValueError) as ex:
        print(str(ex), flush=True)

    print("Vale of name = ", name, flush=True)
    print("Exiting Python Hello World handler", flush=True)
    return response.Response(
        ctx, response_data=json.dumps(
            {"message": "Hello {0}".format(name)}),
        headers={"Content-Type": "application/json"}
    )