From: Jack Desert <jackdesert556@gmail.com>
Subject: Re: GIT counterpart to "svn list"
Date: Wed, 21 Apr 2010 22:37:16 -0500
Message-ID: <20100421223716.6526f625@pennie-farthing>
References: <20100421222237.1758ca66@pennie-farthing>
	<4BCFC180.5020009@dbservice.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/2TR_6JSF0+VhTdCri3ysJk="
Cc: git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 05:37:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4nES-0006UD-NZ
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 05:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315Ab0DVDhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 23:37:25 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:43049 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab0DVDhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 23:37:25 -0400
Received: by gxk27 with SMTP id 27so375933gxk.1
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 20:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type;
        bh=8fl8wnxbOnE1XJBkaxf8qI5afmWdhyJgkyvIgmxNCm8=;
        b=Jq5Z8S2hbIgjTrGSN4ldHidq9Ftcw4ARcsZAo4T/w+eG7pB4AxOk3TmKZBOXrOUCFk
         fLrRuEdsgFKl0yirqqPUYnj7ssYkXrnuDIdVA2qIdR9Ib7stJ/BDPcpDEN1PM590vgRw
         AjzLl06tQZgCE1MTxrdW9O5vSQ86xaihPe8Ik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type;
        b=EEf/h7dSbI29tIGMeT84YKvSty5/7R8oc8jjNWKWY+JQ3M9fpkL5XXNRPmcjfOUVuH
         BBDGWVSllBXWZVQocGpX8wZUKcYB13OnAdxNFVNmA9JsIQ/fLOWg55BFuUDqn4Ro/MXG
         YLQeOZckQ7XHsHv5K3aywN79hmXUMB+aooqvM=
Received: by 10.101.88.12 with SMTP id q12mr15664874anl.212.1271907439332;
        Wed, 21 Apr 2010 20:37:19 -0700 (PDT)
Received: from pennie-farthing (oh-76-1-213-69.dhcp.embarqhsd.net [76.1.213.69])
        by mx.google.com with ESMTPS id 22sm7039517iwn.0.2010.04.21.20.37.18
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 21 Apr 2010 20:37:18 -0700 (PDT)
In-Reply-To: <4BCFC180.5020009@dbservice.com>
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.18.3; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145498>

--MP_/2TR_6JSF0+VhTdCri3ysJk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

El Thu, 22 Apr 2010 05:24:48 +0200
Tomas Carnecky <tom@dbservice.com> escribi=C3=B3:
> On 4/22/10 5:22 AM, Jack Desert wrote:
> >
> > I'm new to GIT, and the one command I can't live without is:
> >    svn list
> > Is ther a GIT couterpart to svn list?
>=20
> We're all clueless about how svn works, or what svn list does. Can you=20
> enlighten us please?
>=20
> tom
>=20
=20
"svn list" displays which files and folders in the current directory are un=
der version control. It's helpful in figuring out which files you still nee=
d to add to the repository. Attached is sample output from one of my direct=
ories under subversion souce control.

-Jack
--=20
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jack Desert     --    Writer, Entrepeneur
Author and Spokesman: www.LetsEATalready.com
Software Developer:   http://GrooveTask.org
Email: JackDesert556@gmail.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--MP_/2TR_6JSF0+VhTdCri3ysJk=
Content-Type: application/octet-stream; name=svn_list_demo
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=svn_list_demo

QmxvZy8KTHl4QmxvZy8KUkVBRE1FLmJ1aWxkCl9faW5pdF9fLnB5CmNvYWxlc2NlLnB5CmlvLwpz
ZWVkLnB5CnRlc3RfY29hbGVzY2UucHkKdGVzdF9zZWVkLnB5CnV0aWwvCg==

--MP_/2TR_6JSF0+VhTdCri3ysJk=--
