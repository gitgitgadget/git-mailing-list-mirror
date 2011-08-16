From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: Using git-svn fetch after a directory change with rewrite-root
Date: Tue, 16 Aug 2011 13:26:43 +0200
Message-ID: <4E4A53F3.6000200@elegosoft.com>
References: <CANWsHyfHtr0EaJtNsDK9UTcmb_AbLg-1jUA-0uWJ-nEeNosb7w@mail.gmail.com> <loom.20110810T152000-152@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: H Krishnan <hetchkay@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 13:27:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtHne-0004Bs-F8
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 13:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683Ab1HPL1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 07:27:10 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:46468 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208Ab1HPL1H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 07:27:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 60CB7DE7F5;
	Tue, 16 Aug 2011 13:27:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eOstlJ-QXe71; Tue, 16 Aug 2011 13:27:00 +0200 (CEST)
Received: from [10.10.10.197] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 68B2DDE7F2;
	Tue, 16 Aug 2011 13:27:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110628 Thunderbird/5.0
In-Reply-To: <loom.20110810T152000-152@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179437>

On 08/10/2011 03:22 PM, H Krishnan wrote: 
> What is the procedure for getting this change into git? Should I contact the 
> person who submitted the original patch?

See Documentation/SubmittingPatches in the Git source tree.

You should CC the people involved.

Cheers.
