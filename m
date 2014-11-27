From: Rex Macey <rex@macey.us>
Subject: Unable to Revert Commit
Date: Thu, 27 Nov 2014 11:35:57 -0500
Message-ID: <547752ED.8010208@macey.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 17:43:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xu29w-00068E-IT
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 17:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbaK0QnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2014 11:43:08 -0500
Received: from p3plsmtpa12-10.prod.phx3.secureserver.net ([68.178.252.239]:38498
	"EHLO p3plsmtpa12-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750780AbaK0QnH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Nov 2014 11:43:07 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Nov 2014 11:43:07 EST
Received: from [192.168.1.127] ([76.122.79.190])
	by p3plsmtpa12-10.prod.phx3.secureserver.net with 
	id Lgbv1p00446Mr1Y01gbvko; Thu, 27 Nov 2014 09:35:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260347>

"Unable to Revert Commit ... Resolve the conflicts in your working 
directory and commit them before trying the revert again".  Please help 
me understand how to resolve the conflicts.  Here's what happened (as 
best as I remember).
Created a windows folder "github_learn" (not under my \documents\github  
folder) ;
Created a file file1.r.
Dragged folder into Github for Windows.  Committed; I could see the file 
in my directory, Github for Windows, and on the server (github.com);
I modified the first file.  Checked that there were different versions 
and then committed it.;
I created a second file, file2.r Committed it.  All good.;
Then I tested whether I could retrieve the first version of file1.r 
(before modification).  In the History area of Github for Windows, I can 
see this version.  I click on that, and then I click on "Revert" which 
produces the error.

I am very new to Git and have read some of the documentation and this 
exercise is my attempt to test myself.  So far my grade is not good.  I 
appreciate any guidance including links to instructions.
Thank you.
Rex Macey
