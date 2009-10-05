From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/6 (v4)] basic revision cache system, no integration or 
	features
Date: Mon, 5 Oct 2009 14:56:56 +0200
Message-ID: <fabb9a1e0910050556y5ed23960n6e0bfd4777bc06f9@mail.gmail.com>
References: <op.uys3qlsjtdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 15:06:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MunGo-0007Yp-8L
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 15:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbZJEM5z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Oct 2009 08:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbZJEM5z
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 08:57:55 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:45808 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932451AbZJEM5y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2009 08:57:54 -0400
Received: by ewy7 with SMTP id 7so3446718ewy.17
        for <git@vger.kernel.org>; Mon, 05 Oct 2009 05:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6v4YGL3J4zCZE6X1mcMjubsLtX+wzl3JkmlXX5HgK+o=;
        b=X+4Vnjv9riVihUTo+kFTjc9Trz6EaEyLq/BYnxYgxjSh97c9e7djOpe+B0jFTaiu6E
         pKypCajXrQsiQKt91tzvvOn5NzKAW5vELHfDz/cp7vTZsseV5R6RJbN98zInbievIfbR
         Myu3npkexGhuCSepJIz008TRbZCGAXUu2LxyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=P9Wpf1MnzgVOK/aw1kbpnNw3cSsVXKulQ7fd897je03xJ6uDHb+Z3cWrtuiPJyvlif
         //cN8HUYfZfKirkf5oGseTCNGnynstW+q6zaiYQX0HxZtk9aS4cSYM95AgxCUxdxYg1w
         FE5r3vFZBH5dY2uNv4dy9BAHNkMZTs+Dfz8mY=
Received: by 10.216.87.68 with SMTP id x46mr1131wee.2.1254747436110; Mon, 05 
	Oct 2009 05:57:16 -0700 (PDT)
In-Reply-To: <op.uys3qlsjtdk399@sirnot.private>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129561>

Heya,

On Mon, Aug 17, 2009 at 14:31, Nick Edelen <sirnot@gmail.com> wrote:
> =A01618 insertions(+)

Really?

--=20
Cheers,

Sverre Rabbelier
