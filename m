From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Splitting the mailing list up
Date: Sun, 26 Sep 2010 19:30:27 +0200
Message-ID: <8AE74FC9-6C7F-433E-A162-E56644847198@wincent.com>
References: <20100925230022.6e2fd389.coolzone@it.dk> <AANLkTikXSfO0uGP1b20jkF09=Mfq0s0+4d4_ANeprXF_@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rico Secada <coolzone@it.dk>, git@vger.kernel.org
To: Sebastien Douche <sdouche@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 19:47:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzvKD-0002fy-Ar
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 19:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757948Ab0IZRrk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 13:47:40 -0400
Received: from outmail128145.authsmtp.net ([62.13.128.145]:64875 "EHLO
	outmail128145.authsmtp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757197Ab0IZRrk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 13:47:40 -0400
X-Greylist: delayed 1020 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Sep 2010 13:47:39 EDT
Received: from mail-c193.authsmtp.com (mail-c193.authsmtp.com [62.13.128.118])
	by punt10.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o8QHUZFD045555;
	Sun, 26 Sep 2010 18:30:35 +0100 (BST)
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id o8QHUVcj047196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 26 Sep 2010 18:30:32 +0100 (BST)
Received: from [192.168.1.6] (7.Red-83-59-198.dynamicIP.rima-tde.net [83.59.198.7] (may be forged))
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o8QHUSSV007825
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 26 Sep 2010 13:30:30 -0400
In-Reply-To: <AANLkTikXSfO0uGP1b20jkF09=Mfq0s0+4d4_ANeprXF_@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
X-Server-Quench: c3ec09ad-c993-11df-97bb-002264978518
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJDkVH aBgdFVdLdwdEHAkR Am4BWFReU18/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwNHGQQZHpS XB4aVRh7cUtDf3Z0 KxVhCyNbVRUuaBV0 S01JFGxSM3ppbzJN TUBYdQFSdApNdhpE Yh4dAXkdAiVbPz4k Hgk8dywxMH1aISVR QwcCZVYTWlpDAyZU 
X-Authentic-SMTP: 61633436303433.1014:706
X-AuthFastPath: 0 (Was 255)
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157244>

El 26/09/2010, a las 18:02, Sebastien Douche escribi=F3:

> On Sat, Sep 25, 2010 at 23:00, Rico Secada <coolzone@it.dk> wrote:
>> Would it be a bad idea to split the Git mailing list up in several
>> sub-categories?
>>=20
>> Example:
>>=20
>> announce@
>> dev@
>> user@
>=20
> Why not, but the simple way is to create another ml for patchs.
> Without patchs, the traffic seems relatively low.

This has come up many times, and been rejected each time. Check the arc=
hives for the reasons why.

Cheers,
Wincent
