From: Simon Ruderich <simon@ruderich.org>
Subject: Re: Repository formats
Date: Tue, 1 Apr 2014 21:55:04 +0200
Message-ID: <20140401195504.GA15272@ruderich.org>
References: <533ACACF.408@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 21:55:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV4mC-0003I0-1f
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 21:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbaDATzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 15:55:08 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:48546 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbaDATzI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 15:55:08 -0400
Received: from localhost (pD9E9601D.dip0.t-ipconnect.de [::ffff:217.233.96.29])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Tue, 01 Apr 2014 21:55:06 +0200
  id 000000000002003C.00000000533B199A.0000684B
Content-Disposition: inline
In-Reply-To: <533ACACF.408@ubuntu.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245645>

On Tue, Apr 01, 2014 at 10:18:55AM -0400, Phillip Susi wrote:
> I have seen some discussion about various changes to the format of the
> index and pack files over time, but can't find anything about it in
> the man pages.  Are the different formats documented anywhere, and how
> to tell which format you are using?

Hello,

The documentation is available in Documentation/technical/, e.g.
index-format.txt and pack-format.txt.

However not everything is available there. For current work on
those formats, check the mailing list archive, e.g. [1]

Regards
Simon

[1]: http://permalink.gmane.org/gmane.comp.version-control.git/233083
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
