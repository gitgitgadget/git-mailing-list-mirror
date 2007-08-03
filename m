From: Robert Schiele <rschiele@gmail.com>
Subject: Re: Shell script cleanups/style changes?
Date: Fri, 3 Aug 2007 02:01:13 +0200
Message-ID: <20070803000113.GX29424@schiele.dyndns.org>
References: <86bqdqkygp.fsf@lola.quinscape.zz> <7vlkctvfk9.fsf@assigned-by-dhcp.cox.net> <85odhpzmbo.fsf@lola.goethe.zz> <20070802214103.GT29424@schiele.dyndns.org> <85vebxy47e.fsf@lola.goethe.zz> <7vwswdsfjp.fsf@assigned-by-dhcp.cox.net> <20070802232126.GU29424@schiele.dyndns.org> <85k5sdy0lk.fsf@lola.goethe.zz> <20070802234515.GW29424@schiele.dyndns.org> <85d4y5xznj.fsf@lola.goethe.zz>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FZIkiClxIZ9JeWSb"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 02:01:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGkba-0006K4-VR
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 02:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758392AbXHCABU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 20:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758241AbXHCABU
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 20:01:20 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:1812 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756856AbXHCABT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 20:01:19 -0400
Received: by mu-out-0910.google.com with SMTP id i10so823519mue
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 17:01:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=m1TCPdKxU1Dz/iIjc0ENYJ90XnAv2VQr7R9aUi/kDTKQI6CDjxghybtwhqcQN5MhLPzlOXKJjR5XEUatZkntK/FZTZ12MV8dtXfS9HBx1WJPg1eEqppKIAAYQOv37L/oYkJ0wiACu2gbwZ3C3LVYc6v1xlWC97zDt9wNuOBZE/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=eRUzp6H59hzWxPSonjOVMYzp/sFbib150x3s1PRAymkZnjFIQrC/E22uJYJDU0KxQhjKx9iSsEvQIzxY30p4Tm82NbhAf9pYLqLZzjNvP1qFWk63O74QcmOnlvvztOF4qZZhrFcoOjGA77Xi8bCvFfk4WJhMHir1Ir5WXQUMG+o=
Received: by 10.86.59.3 with SMTP id h3mr311178fga.1186099277058;
        Thu, 02 Aug 2007 17:01:17 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [87.178.91.135])
        by mx.google.com with ESMTPS id p38sm5048593fke.2007.08.02.17.01.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2007 17:01:15 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 01035C112CF; Fri,  3 Aug 2007 02:01:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <85d4y5xznj.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54651>


--FZIkiClxIZ9JeWSb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 03, 2007 at 01:52:32AM +0200, David Kastrup wrote:
> I was starting to doubt my sanity here.  Sorry that this thread
> resulted in wasted work for you.

That's ok.  I mean I didn't spot the SHELL_PATH thing in the first place
although I already had seen that one before (what I remember now).

At least in that case I don't have to worry any longer since I always can p=
ut
some compliant shell at some random place and use that one.

But at least you have learned now that not everything in the real world loo=
ks
like as it is written in some standard books. ;-)

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--FZIkiClxIZ9JeWSb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGsnBJxcDFxyGNGNcRAm+dAKC3E1I8cyF5po3Rys/WkLS9tYc5ywCgvwBr
5aFv3mzkHvvH+V2XZDsSNPY=
=kW9T
-----END PGP SIGNATURE-----

--FZIkiClxIZ9JeWSb--
