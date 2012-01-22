From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [linux.conf.au] VCS Interoperability
Date: Sun, 22 Jan 2012 18:33:34 -0500
Message-ID: <3BC64515-C4C0-4D32-97B0-8FFD14BB903C@silverinsanity.com>
References: <CAFfmPPMH2643JMMZdVbOQJL7DB-DiRYQS8x0TqEaSbGmhMdBNw@mail.gmail.com> <CALkWK0kMmDMZ4wiMSmOfwBLzd+xBEA+WKsviu9FVcvj9eZEahg@mail.gmail.com> <CAFfmPPOZfDdH+GF91Dxyy5yfX8TmGDmsbpHz=CVLcBY0c-pCsQ@mail.gmail.com> <CALkWK0nsO2EBLUrO_iWAdGYpULt=oug4yPDnczX9c44hzdwzqg@mail.gmail.com> <alpine.DEB.2.02.1201221310540.28747@asgard.lang.hm>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Jan 23 00:33:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rp6v3-00039X-GK
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 00:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467Ab2AVXd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jan 2012 18:33:27 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:48712 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab2AVXd1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jan 2012 18:33:27 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id DBD1B1FFE920; Sun, 22 Jan 2012 23:33:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.141] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id E66AD1FFC0D6;
	Sun, 22 Jan 2012 23:33:15 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.02.1201221310540.28747@asgard.lang.hm>
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188973>


On Jan 22, 2012, at 4:12 PM, david@lang.hm wrote:

> On Sun, 22 Jan 2012, Ramkumar Ramachandra wrote:
> 
>> 3. What are your thoughts on lib'ifying Git so that others can call
>> into it using an API?
> 
> This is something that everyone agrees would be a good thing. There have been many people who have started projects to do so, but they have all stalled.

I believe libgit2 is still under active development.

http://libgit2.github.com
