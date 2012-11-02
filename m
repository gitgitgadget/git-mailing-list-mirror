From: Andreas Ericsson <ae@op5.se>
Subject: Re: Lack of netiquette, was Re: [PATCH v4 00/13] New remote-hg helper
Date: Fri, 02 Nov 2012 10:38:37 +0100
Message-ID: <5093949D.4070509@op5.se>
References: <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com> <20121029215631.GF20513@sigill.intra.peff.net> <alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info> <CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com> <alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info> <CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com> <5090EFCA.7070606@drmicha.warpmail.net> <20121031102712.GB30879@sigill.intra.peff.net> <alpine.DEB.1.00.1210311900450.7256@s15462909.onlinehome-server.info> <CAMP44s2y-co4TELg28==axRmbF7xq3Qp7U8wjg6XtGAUMgf40w@mail.gmail.com> <20121031185903.GA1480@elie.Belkin> <CAMP44s2-UoT03OeTmM9=nh9wCUt84exPNuHyuThp=WQkxvCNLQ@mail.gmail.com> <alpine.DEB.1.00.1210312126080.7256@s15462909.onlinehome-server
 .info> <bec4d263-b458-4636-9fa6-1c1202416810@email.android.com> <CAMP44s2G2MGuPH-UXfoKNOpx0cuSE87Uz=6B-7H1MzJHf6VMjA@mail.gmail.com> <50927D29.3020703@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Nov 02 10:38:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUDiK-0001jM-JT
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 10:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760133Ab2KBJio convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2012 05:38:44 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:63575 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759781Ab2KBJin (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 05:38:43 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so2474490lag.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 02:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=OyRUM69l//FvH7ZuFT83CCf0Px85jCSNQ1k9XmEiddg=;
        b=EcNaaxc4y9f5NXWZsID48rQ4w3o4BA3O9ZMMAzzy+/wcIEh8v3v2hWUaCNJd/OH55V
         M9IDrf+P46YsBE/1OJB0XJI50TjWn/BUjbyEDFni3+vhWtEmZHkPx7GKswH80ItUf7O6
         e9NHJ+MRoyy1goSzOzCQPDzBSbbZPS9ApVRhs/PI4XkM2UqiiucDx3nv4kunqoDY6m5Y
         VLtK5Cp1dgdl7at4IBf/6qi6D91OlPXoiVpdOyBy3klNaasM2gHnddrHlbxoQ26Vxq6U
         vA0YqbKBvtjsO0TCM6V8nIambGpy6G6d/EY5/RaZ/U1idHu3QzSL1DAOH4LpiU1muKt/
         U6ug==
Received: by 10.152.124.111 with SMTP id mh15mr1075030lab.20.1351849121577;
        Fri, 02 Nov 2012 02:38:41 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id ps11sm2939374lab.12.2012.11.02.02.38.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Nov 2012 02:38:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <50927D29.3020703@lsrfire.ath.cx>
X-Gm-Message-State: ALoCoQlznXDbX1id8KqrOaWOZUSjxR7Z4oECypue7WlcZAY9IHvuiCQC1z6Hnn2ziYo6s90Jfnms
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208912>

On 11/01/2012 02:46 PM, Ren=E9 Scharfe wrote:
>=20
> Also, and I'm sure you didn't know that, "Jedem das Seine" (to each
> his own) was the slogan of the Buchenwald concentration camp.  For
> that reason some (including me) hear the unspoken cynical
> half-sentence "and some people just have to be sent to the gas
> chamber" when someone uses this proverb.
>=20

It goes further back than that.

"Suum cuique pulchrum est" ("To each his own is a beautiful thing") is
a latin phrase said to be used frequently in the roman senate when
senators politely agreed to disagree and let a vote decide the outcome
rather than debating further.

Please don't let the twisted views of whatever nazi idiot thought it
meant "you may have the wrong faith and therefore deserve to die, so yo=
u
shall" pollute it. The original meaning is both poetic and democratic,
and I firmly believe most people have the original meaning to the fore
of their mind when using it. After all, very few people knowingly quote
nazi concentration camp slogans.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
