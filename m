From: "Imran M Yousuf" <imran@smartitengineering.com>
Subject: Re: [JGit Patch v2 5/7] Add script for adding second pack for test purpose
Date: Fri, 22 Aug 2008 08:52:39 +0600
Message-ID: <9e85b2570808211952sa903434lacd575388ad2d2d8@mail.gmail.com>
References: <1219288394-1241-1-git-send-email-imyousuf@gmail.com>
	 <1219288394-1241-2-git-send-email-imyousuf@gmail.com>
	 <1219288394-1241-3-git-send-email-imyousuf@gmail.com>
	 <1219288394-1241-4-git-send-email-imyousuf@gmail.com>
	 <1219288394-1241-5-git-send-email-imyousuf@gmail.com>
	 <20080821151252.GS3483@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: imyousuf@gmail.com, git@vger.kernel.org,
	robin.rosenberg@dewire.com,
	"Imran M Yousuf" <imyousuf@smartitengineering.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 04:53:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWMmZ-0001Zl-6X
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 04:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366AbYHVCwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 22:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753321AbYHVCwn
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 22:52:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:18470 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143AbYHVCwm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 22:52:42 -0400
Received: by nf-out-0910.google.com with SMTP id d3so117705nfc.21
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 19:52:40 -0700 (PDT)
Received: by 10.210.51.18 with SMTP id y18mr677492eby.160.1219373560036;
        Thu, 21 Aug 2008 19:52:40 -0700 (PDT)
Received: by 10.210.86.13 with HTTP; Thu, 21 Aug 2008 19:52:39 -0700 (PDT)
In-Reply-To: <20080821151252.GS3483@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93244>

On Thu, Aug 21, 2008 at 9:12 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> imyousuf@gmail.com wrote:
>> From: Imran M Yousuf <imyousuf@smartitengineering.com>
>>
>> Forgot to add it last time and thus adding it before removing duplicate
>> resources.
>
> I would squash this to the one that copies the other resources.

Hi Shawn,

I would gladly make the changes (in this patch and the other ones) if
I am sure that this series does not break the build with Eclipse. I
would be extremely grateful if you would please confirm this to me.

Best regards,

Imran

>
>>  1 files changed, 0 insertions(+), 0 deletions(-)
>>  copy org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/create-second-pack (100%)
>
> --
> Shawn.
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
