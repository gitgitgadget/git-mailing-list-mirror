From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: GIt error
Date: Mon, 17 Jun 2013 15:37:31 +0200
Message-ID: <20130617133731.GC25488@paksenarrion.iveqy.com>
References: <E7FBE41B36DC254CB796CE1D6D45B14A0FAE034D@048-CH1MPN1-032.048d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: justin.sathyanathan@accenture.com
X-From: git-owner@vger.kernel.org Mon Jun 17 15:34:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoZZV-000738-UD
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 15:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515Ab3FQNeJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 09:34:09 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:55015 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119Ab3FQNeH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 09:34:07 -0400
Received: by mail-lb0-f169.google.com with SMTP id d10so2526550lbj.14
        for <git@vger.kernel.org>; Mon, 17 Jun 2013 06:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0eMzvPJTtUH0aRDC2F8gRGq2ChTtT5kystPmdy+Vt9U=;
        b=HhhIiT35vIf4qSgZxSoaOEBSpBIgLKZYNIHpMHVrBwky3PUVZepfa+ZexS9/SjEfPr
         qadEUN+4dccAEI7vbK/5l+Tv5jy+aQooA0VoCWL+8zdNsYD83IwPwi0dTr/zf2RYydK4
         ihT0wRSm9FJf/35wsnvY/l8Kg4VNHBGh/Ymu1rTx0mJHpF+z4mTX4TRcUwuQ8pWR8shC
         j6w8LnzXgL1u6HuyQr/2bGHuaiFcBbMhWuk3h16EysD81dIwUtVDazY2ZFpMA7D43ZZn
         ROG0wrl0AHJLEm1f7c1ha+Wg/rh0NZq/VDcLwGOkNAw24mlJJsyNlrRNba9Or9Bvwo8u
         njBg==
X-Received: by 10.152.1.134 with SMTP id 6mr6516192lam.16.1371476045542;
        Mon, 17 Jun 2013 06:34:05 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id e9sm5464084lbj.3.2013.06.17.06.34.04
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 17 Jun 2013 06:34:04 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UoZch-0003j9-O1; Mon, 17 Jun 2013 15:37:31 +0200
Content-Disposition: inline
In-Reply-To: <E7FBE41B36DC254CB796CE1D6D45B14A0FAE034D@048-CH1MPN1-032.048d.mgd.msft.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228068>

On Mon, Jun 17, 2013 at 01:28:30PM +0000, justin.sathyanathan@accenture=
=2Ecom wrote:
> 1.Iam getting error attached when cloning of repository is done:

What error?

> 2.Also, when file is tried to be added,it gives error below:
>=20
> $ git add *
> fatal: unable to stat 'src/development_architecture/integration_appli=
cation_proj
> ect_template/provider_archetype/provider_archetype/src/main/resources=
/archetype-
> resources/__rootArtifactId__-data/src/main/java/com/accenture/afpj/sa=
mple/skelet
> on/visitor/data/VisitorRepositoryJpaImpl.java': Filename too long

As it said, filename is too long.
See the FAQ:
https://github.com/msysgit/msysgit/wiki/Frequently-Asked-Questions
and the thread:
http://thread.gmane.org/gmane.comp.version-control.msysgit/14572

> Request you to help to resolve same asap as it is affecting the proje=
ct.
If you want reliable and direct help I suggest you hire a git-consult o=
r
buy support. This list will help you in the best way it can (and mostly
that's enough) but cannot do things "asap".

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
