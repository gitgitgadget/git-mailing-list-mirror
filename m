From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: Re: [PATCH] config doc: user.signingkey is also used for signed
 commits
Date: Mon, 14 Oct 2013 19:22:32 +0200
Message-ID: <20131014172232.GV4589@mars-attacks.org>
References: <1381770276-12062-1-git-send-email-boklm@mars-attacks.org>
 <20131014171546.GA12907@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 19:22:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVlqq-0001sq-2i
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 19:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756724Ab3JNRWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 13:22:36 -0400
Received: from mx0.mars-attacks.org ([92.243.25.60]:47514 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714Ab3JNRWf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 13:22:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id CE3A33EC9;
	Mon, 14 Oct 2013 19:22:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Z9aLkCPlCB5X; Mon, 14 Oct 2013 19:22:47 +0200 (CEST)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 3A4F015CE;
	Mon, 14 Oct 2013 19:22:47 +0200 (CEST)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 059CA43920; Mon, 14 Oct 2013 19:22:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20131014171546.GA12907@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236107>

On Mon, 14 Oct 2013, Jonathan Nieder wrote:

> Nicolas Vigier wrote:
> 
> > The description of the user.signingkey option only mentioned its use
> > when creating a signed tag. Make it clear that is is also used when
> > creating signed commits.
> > ---
> >  Documentation/config.txt | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> Thanks.  May we have your sign-off?  (See Documentation/SubmittingPatches
> section 5 "Sign your work" for what this means.)

Oops, I forgot to add it :
Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>

Thanks
