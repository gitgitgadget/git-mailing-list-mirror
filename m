From: astubbs <antony.stubbs@gmail.com>
Subject: Re: git gui rescane_stage2 error on windows
Date: Tue, 30 Sep 2008 10:43:54 -0700 (PDT)
Message-ID: <1222796634378-1129570.post@n2.nabble.com>
References: <1222796473795-1129562.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 19:45:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkjHW-0000T7-E0
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 19:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbYI3Rn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 13:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753072AbYI3Rn4
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 13:43:56 -0400
Received: from kuber.nabble.com ([216.139.236.158]:53057 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbYI3Rn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 13:43:56 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1KkjGM-0001nt-CR
	for git@vger.kernel.org; Tue, 30 Sep 2008 10:43:54 -0700
In-Reply-To: <1222796473795-1129562.post@n2.nabble.com>
X-Nabble-From: antony.stubbs@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97136>


Ok, that's odd. nabble and chrome ate the line breaks

Fresh install and fresh repository on Vista.
Getting this error when launching git gui:
child process exited abnormally
child process exited abnormally    
while executing"close $fd"
    (procedure "rescan_stage2" line 7)
    invoked from within"rescan_stage2
 file1192de8 ui_ready"

Any ideas?git version 1.6.0.2

git version 1.6.0.2


astubbs wrote:
> 
> Fresh install and fresh repository on Vista.Getting this error when
> launching git gui:child process exited abnormallychild process exited
> abnormally    while executing"close $fd"    (procedure "rescan_stage2"
> line 7)    invoked from within"rescan_stage2 file1192de8 ui_ready"Any
> ideas?git version 1.6.0.2
> 

-- 
View this message in context: http://n2.nabble.com/git-gui-rescane_stage2-error-on-windows-tp1129562p1129570.html
Sent from the git mailing list archive at Nabble.com.
