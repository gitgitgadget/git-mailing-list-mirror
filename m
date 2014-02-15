From: David Kastrup <dak@gnu.org>
Subject: Is there something like a blamed diff?
Date: Sat, 15 Feb 2014 19:38:32 +0100
Message-ID: <8738jk1as7.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 15 19:56:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEkPS-0002GL-Cm
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 19:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbaBOS4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Feb 2014 13:56:13 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:58374 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493AbaBOS4M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Feb 2014 13:56:12 -0500
Received: from localhost ([127.0.0.1]:57413 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WEkPL-0004Io-ON
	for git@vger.kernel.org; Sat, 15 Feb 2014 13:56:11 -0500
Received: by lola (Postfix, from userid 1000)
	id A5481E7240; Sat, 15 Feb 2014 19:38:32 +0100 (CET)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242197>


When comparing two branches, decorating the flat diff with the
respectively responsible commits seems like it would be nice to do/have
(the blame on the identical parts, in contrast, is not really
interesting).  Is there any tool that provides something like that?

-- 
David Kastrup
