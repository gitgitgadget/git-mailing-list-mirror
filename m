From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: am fails to apply patches for files with CRLF lineendings
Date: Tue, 15 Dec 2009 07:33:13 +0100
Message-ID: <fabb9a1e0912142233u42fc4bb6k70ef7c539cc1ae76@mail.gmail.com>
References: <20091214183337.GA25462@atjola.homenet> <7vvdg9i9mn.fsf@alter.siamese.dyndns.org> 
	<tCQlJn153g8Oa6Z9HKe6xOUQJdcf2PCIVthlTrLgYE-wJ5jFyXVXWw@cipher.nrlssc.navy.mil> 
	<7vhbrtdtth.fsf@alter.siamese.dyndns.org> <ee63ef30912141650ie05baf4kab8505adf160c62e@mail.gmail.com> 
	<ee63ef30912141809k27bc73edp20abddd5e9c7c063@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 07:33:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKQyg-0000d7-1f
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 07:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbZLOGdg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Dec 2009 01:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbZLOGdf
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 01:33:35 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:61376 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbZLOGde convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Dec 2009 01:33:34 -0500
Received: by vws30 with SMTP id 30so886877vws.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 22:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=RnTHHz2UBuOh1xIYZUZTBYX48ZSl6kLalRUIQdSiIVk=;
        b=IqyaoNcJaApeukNLVrAzgG8woabiuzjfnNWmqobetYVz1SMNnAM3FhaPEmsFY5u56R
         soUpoknQP3LJAawxPeLPe3HjnA7A/imMFljZSsB2wTB9BqUh9adkp5Ah2NOi7f23SLDt
         3tWF6WLz5ZEDS/ZJOZpVjYcofIpxwpzoV6/rY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uFjASf8iApdoYk4cYlqVUV7a2efyKT8nGAyezPYQ++2TNJ3+E951OmIGZGFkIgTzAe
         qFQostg9tiPG5mNfLdyXT9QGS2wYFiIo6L73xoAnCuuJOz08YF38U67nt8Cb6ntQ93fq
         4dd6I+Gp/0Ecamawc5Z6uHMN2VxHU1rt4NIFI=
Received: by 10.220.65.200 with SMTP id k8mr1088653vci.56.1260858813162; Mon, 
	14 Dec 2009 22:33:33 -0800 (PST)
In-Reply-To: <ee63ef30912141809k27bc73edp20abddd5e9c7c063@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135272>

Heya,

On Tue, Dec 15, 2009 at 03:09, Brandon Casey <drafnel@gmail.com> wrote:
> Forwarding to the list. =A0The original was bounced since gmail sent =
a
> multipart mime version with html. =A0Seems we can't disable html
> composing in the gmail settings anymore (I thought we used to be able
> to).

You can, it remembers when you click "=AB=A0Plain=A0Text", at least, it=
 does
for me :P.

--
Cheers,

Sverre Rabbelier
