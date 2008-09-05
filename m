From: "Imran M Yousuf" <imran@smartitengineering.com>
Subject: Re: [JGIT PATCH 2/2] Move pathOf to RepositoryTestCase and use it for locating test files
Date: Fri, 5 Sep 2008 07:48:49 +0600
Message-ID: <9e85b2570809041848x6b232508y535974e6036eed51@mail.gmail.com>
References: <20080903091022.GC23406@diku.dk>
	 <20080903170904.GB28315@spearce.org>
	 <9e85b2570809031847r34a760ecwea365930327eb205@mail.gmail.com>
	 <20080904032118.GA3262@spearce.org> <20080904092311.GA25735@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Imran M Yousuf" <imyousuf@smartitengineering.com>,
	"Robin Rosenberg" <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Jonas Fonseca" <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Sep 05 03:53:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbQW1-0001HA-Vk
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 03:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbYIEBsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 21:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbYIEBsv
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 21:48:51 -0400
Received: from qb-out-0506.google.com ([72.14.204.236]:10106 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbYIEBsv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 21:48:51 -0400
Received: by qb-out-0506.google.com with SMTP id f11so293502qba.17
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 18:48:50 -0700 (PDT)
Received: by 10.210.114.15 with SMTP id m15mr12875155ebc.45.1220579329144;
        Thu, 04 Sep 2008 18:48:49 -0700 (PDT)
Received: by 10.210.113.7 with HTTP; Thu, 4 Sep 2008 18:48:49 -0700 (PDT)
In-Reply-To: <20080904092311.GA25735@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94987>

On Thu, Sep 4, 2008 at 3:23 PM, Jonas Fonseca <fonseca@diku.dk> wrote:
> Shawn O. Pearce <spearce@spearce.org> wrote Wed, Sep 03, 2008:
>> Imran M Yousuf <imran@smartitengineering.com> wrote:
>> > Almighty willing, I will submit my patches this weekend (on Saturday).
>> > I develop in NetBeans so that would make it easier for sure.
>
> Perfect. You might be interested in the hopefully soon to be released
> jgit-based nbgit module:
>
>  - http://nbgit.googlecode.com/
>
> The feature set is limited but some of the basics features should be
> there.

Ah great! I am really interested in it, I scheduled time on November
to develop it since you have already started on it I guess I will join
you guys. I had a discussion with Alex Coles couple of months back he
was using CLI output for the purpose, its nice to see JGit being used
as I suggested him the same. Let me get a little free and I will join
that project as well.

Cheers,

Imran

>
>> Awesome.  Then I'll hold off on Jonas' patch for now.
>
> Super.
>
> --
> Jonas Fonseca
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
