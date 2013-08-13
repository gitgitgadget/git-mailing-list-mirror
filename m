From: Thorsten Glaser <tg@mirbsd.de>
Subject: Re: git should not use a default user.email config value
Date: Tue, 13 Aug 2013 08:39:29 +0000 (UTC)
Message-ID: <Pine.BSM.4.64L.1308130837390.20692@herc.mirbsd.org>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
 <20130809194214.GV14690@google.com> <vpq4nauhubt.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 13 10:41:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9AAX-000567-3R
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 10:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755319Ab3HMIl1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Aug 2013 04:41:27 -0400
Received: from eurynome.mirbsd.org ([81.169.181.30]:45096 "EHLO
	eurynome.mirbsd.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121Ab3HMIlZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Aug 2013 04:41:25 -0400
Received: from herc.mirbsd.org (root@herc.mirbsd.org [IPv6:2a01:198:25d:0:202:b3ff:feb7:54e8])
	by eurynome.mirbsd.org (8.14.5.Beta0/8.14.3) with ESMTP id r7D8fEXf014171
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Tue, 13 Aug 2013 08:41:22 GMT
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
	by herc.mirbsd.org (8.14.5/8.14.5) with ESMTP id r7D8dUL6029760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 13 Aug 2013 08:39:34 GMT
X-X-Sender: tg@herc.mirbsd.org
In-Reply-To: <vpq4nauhubt.fsf@anie.imag.fr>
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/getpine/pcpine.html for free.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232218>

Matthieu Moy dixit:

>An opt-in auto-detection would be cool for people who really work in a
>controlled environment, so that the sysadmin could enable it from

Sounds like a plan ;-)

I think with several people chiming in on this, while that proposal
would affect a majority of people, it would do so in a less intrusive
way as the current behaviour of autodetection which negatively affects
some users, although not few either, in a strong way.

bye,
//mirabilos
--=20
> emacs als auch vi zum Kotzen finde (joe rules) und pine f=C3=BCr den =
einzig
> bedienbaren textmode-mailclient halte (und ich hab sie alle ausprobie=
rt). ;)
Hallooooo, ich bin der Holger ("Hallo Holger!"), und ich bin ebenfalls
=2E.. pine-User, und das auch noch gewohnheitsm=C3=A4=C3=9Fig ("Ooooooo=
ohhh").  [aus dasr]
