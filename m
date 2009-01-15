From: David Birchfield <dbirchfield@asu.edu>
Subject: Re: jgit merge question
Date: Wed, 14 Jan 2009 20:47:17 -0700
Message-ID: <7F1F22DF-7E4F-4888-A404-2A68F663989A@asu.edu>
References: <S1760244AbZANHqN/20090114074613Z+1959@vger.kernel.org> <4EDE3D74-CEA3-473C-ADD1-03B79AAB9EDF@asu.edu> <alpine.DEB.1.00.0901141124460.3586@pacific.mpi-cbg.de> <20090114153034.GZ10179@spearce.org> <AB447EEF7BAAB7489B29A4F3F788D02C01CDD792@EX07.asurite.ad.asu.edu> <20090114231222.GB10179@spearce.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 04:48:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNJDn-0006Du-Iq
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 04:48:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624AbZAODrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 22:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754332AbZAODrT
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 22:47:19 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:59442 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbZAODrS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 22:47:18 -0500
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090115034717.JODH11567.fed1rmmtao104.cox.net@fed1rmimpo03.cox.net>
          for <git@vger.kernel.org>; Wed, 14 Jan 2009 22:47:17 -0500
Received: from [10.0.1.195] ([98.165.228.151])
	by fed1rmimpo03.cox.net with bizsmtp
	id 3fnH1b00H3GdtNi04fnH7d; Wed, 14 Jan 2009 22:47:18 -0500
X-Authority-Analysis: v=1.0 c=1 a=3ck649rCqzRSuTm6mqAA:9
 a=b0rfOYR6HK1VIfTM0vcBlHf5CocA:4 a=PLsYINawJ5cA:10 a=HEdnscJc8mAA:10
 a=bc-At0-sGGwA:10
X-CM-Score: 0.00
In-Reply-To: <20090114231222.GB10179@spearce.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105762>

thanks again for your help, and really sorry for the newbie questions.

how do I grab those 8 commits?

I did originally use git clone on this uri: git:// 
android.git.kernel.org/tools/egit.git - but I don't see the  
modifications there.

thanks again,
david


On Jan 14, 2009, at 4:12 PM, Shawn O. Pearce wrote:

>>
>
> Instead of copying 4 files, why don't you actually fetch the 8
> commits and merge them into your local repository?  You are getting
> build errors because you didn't get an exception type in the errors
> directory, and at least two existing classes had new methods added
> to them in order to support the merge API.
>
> -- 
> Shawn.
