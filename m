From: Alfred Perlstein <alfred@freebsd.org>
Subject: Re: [PATCH] Document the 'svn propset' command.
Date: Wed, 15 Jun 2016 13:24:42 -0700
Message-ID: <FBF1CB04-C2EE-4675-8FC0-69A48410BB48@freebsd.org>
References: <20160612191550.GA14160@elvis.mu.org> <20160615051950.GA93388@elvis.mu.org> <20160615201556.GA6303@dcvr.yhbt.net> <xmqqvb1a5hlf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Eric Wong <e@80x24.org>, git@vger.kernel.org,
	Joseph Pecoraro <pecoraro@apple.com>,
	David Fraser <davidf@sjsoft.com>,
	Pranit Bauva <pranit.bauva@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 22:25:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDHN1-0004in-Cc
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 22:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933205AbcFOUYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 16:24:48 -0400
Received: from elvis.mu.org ([192.203.228.196]:56932 "EHLO elvis.mu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933049AbcFOUYq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2016 16:24:46 -0400
Received: from [100.110.218.22] (222.sub-70-197-11.myvzw.com [70.197.11.222])
	by elvis.mu.org (Postfix) with ESMTPSA id D0759346DFA7;
	Wed, 15 Jun 2016 13:24:43 -0700 (PDT)
X-Mailer: iPhone Mail (13F69)
In-Reply-To: <xmqqvb1a5hlf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297399>



> On Jun 15, 2016, at 1:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Eric Wong <e@80x24.org> writes:
> 
>> Thanks Alfred,
>> 
>> I've removed the '.' from the commit subject, signed-off,
>> and pushed to my repo for Junio:
>> 
>> The following changes since commit 05219a1276341e72d8082d76b7f5ed394b7437a4:
>> 
>>  Git 2.9 (2016-06-13 10:42:13 -0700)
>> 
>> are available in the git repository at:
>> 
>>  git://bogomips.org/git-svn.git svn-propset-doc
>> 
>> for you to fetch changes up to f3961b2eba8ba6aa2fddc827ddf5c26b41391872:
>> 
>>  Document the 'svn propset' command (2016-06-15 20:11:22 +0000)
> 
> I actually queued it directly on top of v2.3.0-rc0~32^2 (git-svn:
> support for git-svn propset, 2014-12-07) so that it could go to
> older maintenance tracks.
> 
> I will pick up your Reviewed-by: and redo it.  Thanks.
> 

Thank you, always great working with the git project!  

-Alfred 
