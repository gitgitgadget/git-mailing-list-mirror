X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation tutorial.txt: Teach the reader about git commit -a -s
Date: Mon, 20 Nov 2006 17:52:20 -0500
Message-ID: <20061120225220.GG12285@fieldses.org>
References: <4d8e3fd30611201430l6135814yc89f4abdb9044340@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 22:53:06 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4d8e3fd30611201430l6135814yc89f4abdb9044340@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31950>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmI01-0002Nd-4p for gcvg-git@gmane.org; Mon, 20 Nov
 2006 23:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966669AbWKTWwW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 17:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966450AbWKTWwV
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 17:52:21 -0500
Received: from mail.fieldses.org ([66.93.2.214]:45767 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S966671AbWKTWwV (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 17:52:21 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GmHzw-0006OP-2l; Mon, 20 Nov 2006
 17:52:20 -0500
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Sender: git-owner@vger.kernel.org

On Mon, Nov 20, 2006 at 11:30:56PM +0100, Paolo Ciarrocchi wrote:
> I think it's important to mention, in the collaboration section,
> that is possible to use the -s option to add the Signed-off-by
> line
> 
> Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>

The -s option is easy to learn later, and isn't really necessary for
basic project management; I'd rather leave it out of the first tutorial.

(In fact, the best place for it may be in SubmittingPatches or
equivalent for the particular project.)

