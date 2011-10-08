From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Display line numbers in gitk?
Date: Sat, 08 Oct 2011 15:27:03 +0200
Message-ID: <4E904FA7.2060606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 15:27:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCWw9-000563-A6
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 15:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897Ab1JHN13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 09:27:29 -0400
Received: from lo.gmane.org ([80.91.229.12]:55254 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070Ab1JHN12 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 09:27:28 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RCWw2-00054Y-46
	for git@vger.kernel.org; Sat, 08 Oct 2011 15:27:26 +0200
Received: from p5ddb05f2.dip0.t-ipconnect.de ([93.219.5.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 15:27:26 +0200
Received: from sschuberth by p5ddb05f2.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 15:27:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb05f2.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183142>

Hi,

is there currently a way to display line numbers next to each line in 
the diff shown by gitk, e.g. in some kind of gutter?

If that's currently not possible, how much work would it require to add 
that feature as an option?

-- 
Sebastian Schuberth
