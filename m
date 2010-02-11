From: David Abrahams <dave@boostpro.com>
Subject: Separate default push/pull?
Date: Thu, 11 Feb 2010 11:36:04 -0500
Message-ID: <m2zl3fg26j.fsf@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 17:45:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfcAN-0006Xk-Ff
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 17:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928Ab0BKQpM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 11:45:12 -0500
Received: from boostpro.com ([206.217.198.21]:40086 "EHLO boostpro.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753222Ab0BKQpL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2010 11:45:11 -0500
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2010 11:45:11 EST
Received: from zreba.local (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
	(Authenticated sender: dave)
	by boostpro.com (Postfix) with ESMTPSA id BBE2814BA9D;
	Thu, 11 Feb 2010 16:36:05 +0000 (GMT)
Received: by zreba.local (Postfix, from userid 501)
	id D55721AA76B7; Thu, 11 Feb 2010 11:36:04 -0500 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139607>


If I am collaborating mostly with one other person, I typically want to
pull from his publicly-readable repo and push to mine (on which I have
write permission).  Is there any way to set things up so =E2=80=9Cgit p=
ull=E2=80=9D and
=E2=80=9Cgit push=E2=80=9D without additional arguments will do this by=
 default?

Thanks,

--=20
Dave Abrahams           Meet me at BoostCon: http://www.boostcon.com
BoostPro Computing
http://www.boostpro.com
