From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Known issues in Git
Date: Thu, 3 Dec 2015 18:35:39 +0100
Message-ID: <20151203173539.GE7387@paksenarrion.iveqy.com>
References: <147DA09451DF1842B91E3ECB29E35B3412CB5A9F@DDCRRUE121.corp.draeger.global>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Hamann, Kerstin" <Kerstin.Hamann@draeger.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 18:35:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4XnH-0001QY-Nb
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 18:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbbLCRfn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Dec 2015 12:35:43 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33531 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbbLCRfm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Dec 2015 12:35:42 -0500
Received: by lbbkw15 with SMTP id kw15so6079372lbb.0
        for <git@vger.kernel.org>; Thu, 03 Dec 2015 09:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=m9OlJDeaprOPiAcAbUoa7rQMCaH4HVsYMiWaYUAwjg4=;
        b=lhjEDwFMxqN8FN0uriYJojcrOny+GuYFCFiS0oT/NgYBdfqQxBnMFXOMCZ6cn/IkxX
         T70ZMalHng8Mm6kwZ4oiaQWC44AhFljmTduxzyUy6oTJP+wwKAPeN/J0DAv1k2UWr5gd
         cI7cXOWtaWgS9WXmDeCqHIibO9Q4dJEWNKiLceuwDwfeNgnxvXvluE35479r2wEljtQz
         VIAmiBFaPAj9VmtscFjpWEf4pYYkBLyqdCGbBWENwUmtjPRNqefsBJs1QXLKfSZUCZM6
         G/LrJNpjFTs+j7N8gYloIFUlRyGdfyvP4AebXBtC/FMXWRjtCAkRTu/TDdMShQ8x8Sw3
         LwWA==
X-Received: by 10.112.172.130 with SMTP id bc2mr1455334lbc.132.1449164141255;
        Thu, 03 Dec 2015 09:35:41 -0800 (PST)
Received: from paksenarrion.paks.iveqy.com (c83-249-17-125.bredband.comhem.se. [83.249.17.125])
        by smtp.gmail.com with ESMTPSA id m64sm1562717lfd.45.2015.12.03.09.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2015 09:35:40 -0800 (PST)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1a4Xn9-000184-Dr; Thu, 03 Dec 2015 18:35:39 +0100
Content-Disposition: inline
In-Reply-To: <147DA09451DF1842B91E3ECB29E35B3412CB5A9F@DDCRRUE121.corp.draeger.global>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281958>

On Thu, Dec 03, 2015 at 03:14:31PM +0000, Hamann, Kerstin wrote:
> Hi,
>=20
> I would like to have a list of known issues for Git (Server and Clien=
t) in order to do the risk analysis for Git and Bitbucket usage for a s=
oftware project in the medical device development. Where can I find suc=
h a =C2=A0list? For Bitbucket it is easy (go to jira and open the proje=
ct).=20
> Note: Configuration management tools for software projects in a regul=
ated environment (IEC62304) have to be validated. That is not a big iss=
ue but that have to be done before a new git version is installed.
>=20
> Regards Brita
>=20
> --- This communication contains confidential information. If you are =
not the intended recipient please return this email to the sender and d=
elete it from your records. Diese Nachricht enthaelt vertrauliche Infor=
mationen. Sollten Sie nicht der beabsichtigte Empfaenger dieser E-mail =
sein, senden Sie bitte diese an den Absender zurueck und loeschen Sie d=
ie E-mail aus Ihrem System.
> N?????r??y????b?X??=C7=A7v?^?)=DE=BA{.n?+????=D8=A7?=17??=DC=A8}???=C6=
=A0z?&j:+v???=07????zZ+??+zf???h???~????i???z?=1E?w?????????&?)=DF=A2=1B=
f

Hi!
here's the returned email as you requested. I'll now delete your email.

--=20
=46redrik Gustafsson

phone: +46 733-608274
e-mail: iveqy@iveqy.com
website: http://www.iveqy.com
