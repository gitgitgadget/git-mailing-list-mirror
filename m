From: Nicolas Morey-Chaisemartin <devel@morey-chaisemartin.com>
Subject: SPEC files for Git
Date: Mon, 01 Dec 2008 16:16:22 +0100
Message-ID: <4933FFC6.8080306@morey-chaisemartin.com>
Reply-To: devel@morey-chaisemartin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 16:27:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Agh-0001ld-NI
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 16:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbYLAP0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 10:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbYLAP0f
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 10:26:35 -0500
Received: from 29.mail-out.ovh.net ([87.98.216.213]:42113 "HELO
	29.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751387AbYLAP0e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 10:26:34 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Dec 2008 10:26:34 EST
Received: (qmail 32377 invoked by uid 503); 1 Dec 2008 15:20:01 -0000
Received: from unknown (HELO mail95.ha.ovh.net) (213.186.33.59)
  by 29.mail-out.ovh.net with SMTP; 1 Dec 2008 15:20:01 -0000
Received: from b0.ovh.net (HELO queue-out) (213.186.33.50)
	by b0.ovh.net with SMTP; 1 Dec 2008 15:19:53 -0000
Received: from ensilinx1.imag.fr (HELO ?0.0.0.0?) (devel@morey-chaisemartin.com@195.221.227.189)
  by ns0.ovh.net with SMTP; 1 Dec 2008 15:19:52 -0000
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
X-Enigmail-Version: 0.95.7
X-Ovh-Tracer-Id: 42784197872176862
X-Ovh-Remote: 195.221.227.189 (ensilinx1.imag.fr)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|H 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102049>

Hi,

I'm trying to recompile gitweb1.6.0.4-1 for RHEL5, but I'm missing the
spec file.
I've checked the git SRP. It generates a lot of things but no RPM for
gitweb.

Is there any place with an official spec file? Or has anyone made one
which he could share?

Best regards

Nicolas
