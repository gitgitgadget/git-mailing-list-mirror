From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: git commit -v does not removes the patch
Date: Mon, 10 Nov 2008 16:20:51 +0100
Message-ID: <adf1fd3d0811100720n52ac1d47id9b7f402412aa0d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 10 16:22:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzYah-0001Kp-BH
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 16:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026AbYKJPUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 10:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753971AbYKJPUy
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 10:20:54 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:6758 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845AbYKJPUx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 10:20:53 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1104955nfc.21
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 07:20:52 -0800 (PST)
Received: by 10.103.231.15 with SMTP id i15mr3799762mur.35.1226330451944;
        Mon, 10 Nov 2008 07:20:51 -0800 (PST)
Received: by 10.103.165.1 with HTTP; Mon, 10 Nov 2008 07:20:51 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100525>

Hi *,

  $subject since:

4f672ad (wt-status: load diff ui config, 2008-10-26)

I tried to make a test case, but failed. I think because it is a bit
tricky the fake_editor/stdin/stdout stuff, so at the end I bisected it
by hand

Regards,
Santi
