From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Best newbie / advanced / expert reference texts for Git?
Date: Fri, 19 Nov 2010 07:44:13 -0800 (PST)
Message-ID: <m3vd3t48uy.fsf@localhost.localdomain>
References: <AANLkTikctrASqX0FLCOapyJCt1VqG6_cxs_oXJ6fExZC@mail.gmail.com>
	<AANLkTik5ZYC66NicUvbDxJMiR_0iK3vPRAf9dGAQu+qW@mail.gmail.com>
	<AANLkTin_kS_2d=ajuGo-V_OWsF91xSb=SeKmrX9Aghe8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Patrick Doyle <wpdster@gmail.com>, Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 16:44:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJT8b-000489-Fw
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 16:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798Ab0KSPoR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Nov 2010 10:44:17 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53290 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677Ab0KSPoQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Nov 2010 10:44:16 -0500
Received: by mail-fx0-f46.google.com with SMTP id 13so775034fxm.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 07:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=i6dL5uR38POiHLsHPCWGS3FAA+/O8Nu31D/yxb1pQSQ=;
        b=KLcU0lBCsos2IxMjm8e9of2jT2Z+59w77sDLz+0FemKnEoYA3miQ72LQEwRwNXK6Bc
         AKUwfmEjVfsygrYieBXXvuc52onqasjts8KlkRkUCB/B8jVGDMvc9XofwWBlIsoltz9B
         jefUj9dpy9Shro1pEf3Is0Eo/wVKTucOePx6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=h6mt+RpGgIOYTVsiDjCxHG5X5V1oiCIJ/A+xItaH9MFTQzhfIquqlyvkNN7vwvtKwr
         DS4Je6Fz9pqyrYrkBQ+QGvY22qOysUfmEChVtoArPS7xhliRO+JtbURxWyAAM15si0fl
         6tEXvLPv56uAuyd+9Q8zGqGX3QRsCYp92PfaM=
Received: by 10.223.118.211 with SMTP id w19mr999027faq.14.1290181455144;
        Fri, 19 Nov 2010 07:44:15 -0800 (PST)
Received: from localhost.localdomain (abwo119.neoplus.adsl.tpnet.pl [83.8.238.119])
        by mx.google.com with ESMTPS id p18sm551360faa.16.2010.11.19.07.44.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 07:44:13 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oAJFhl5L011043;
	Fri, 19 Nov 2010 16:43:52 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oAJFhYqn011037;
	Fri, 19 Nov 2010 16:43:34 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTin_kS_2d=ajuGo-V_OWsF91xSb=SeKmrX9Aghe8@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161759>

Dun Peal <dunpealer@gmail.com> writes:
> On Fri, Nov 19, 2010 at 11:18 AM, Patrick Doyle <wpdster@gmail.com> w=
rote:

> > Check out http://progit.org/. =A0I am not affiliated with the autho=
r(s)
> > or the web site.=A0I just stumbled across it a couple of weeks ago =
when
> > I went to set up a git server for our group.=A0It seems to answer e=
very
> > question I've ever had about git, and then some.
>=20
> Thanks; sounds like it should serve well for the Advanced and possibl=
y
> Intermediate categories. Still need a good text for the Newbie class.
>=20
> P.S. I glanced at it briefly and it seemed a bit out of date, but
> perhaps my inspection was too cursory.

"Pro Git" out of date.  Oh really?  It is kept quite up to date (for
example adding information about "gitolite" and "smart" HTTP
transport), see https://github.com/progit/progit

As to other documentation, see
  https://git.wiki.kernel.org/index.php/GitDocumentation

--=20
Jakub Narebski
Poland
ShadeHawk on #git
