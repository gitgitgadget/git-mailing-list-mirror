From: Daniel Convissor <danielc@analysisandsolutions.com>
Subject: Re: config for merging master to test branch
Date: Tue, 29 Dec 2009 11:43:44 -0500
Message-ID: <20091229164343.GA17546@panix.com>
References: <20091228233838.GA28052@panix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 29 17:43:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPfAk-00073O-EK
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 17:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbZL2Qnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 11:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbZL2Qnp
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 11:43:45 -0500
Received: from mail1.panix.com ([166.84.1.72]:64728 "EHLO mail1.panix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355AbZL2Qnp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 11:43:45 -0500
Received: from panix5.panix.com (panix5.panix.com [166.84.1.5])
	by mail1.panix.com (Postfix) with ESMTP id 6AF121F08B
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 11:43:44 -0500 (EST)
Received: by panix5.panix.com (Postfix, from userid 14662)
	id 5F0742422B; Tue, 29 Dec 2009 11:43:44 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20091228233838.GA28052@panix.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135808>

Hello Again Folks:

On Mon, Dec 28, 2009 at 06:38:39PM -0500, Daniel Convissor wrote:
> 
> Now, here's the question.  I want to go back into the testing directory 
> and do a "git pull" and have the changes from master automatically merged 
> into my test branch in one step, without having to do an explicit set of 
> checkouts and merges.

I found this is possible by being in the "test" checkout and calling
"git pull origin master".  Is this the best way to do it?

Thanks,

--Dan

-- 
 T H E   A N A L Y S I S   A N D   S O L U T I O N S   C O M P A N Y
            data intensive web and database programming
                http://www.AnalysisAndSolutions.com/
 4015 7th Ave #4, Brooklyn NY 11232  v: 718-854-0335 f: 718-854-0409
