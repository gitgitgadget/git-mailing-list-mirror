From: Bill Lear <rael@zopyra.com>
Subject: Re: A couple branch questions
Date: Wed, 13 Feb 2008 20:24:35 -0600
Message-ID: <18355.42595.377377.433309@lisa.zopyra.com>
References: <76718490802131739n22c56cadn39c1871ea1762dc3@mail.gmail.com>
	<ee77f5c20802131745p23aa1db3j47207f1e6538b0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Jay Soffian" <jaysoffian@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 03:25:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPTmy-00014k-Tc
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 03:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbYBNCYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 21:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbYBNCYi
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 21:24:38 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61462 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081AbYBNCYi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 21:24:38 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id m1E2Oaa21052;
	Wed, 13 Feb 2008 20:24:36 -0600
In-Reply-To: <ee77f5c20802131745p23aa1db3j47207f1e6538b0e@mail.gmail.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73842>

On Wednesday, February 13, 2008 at 17:45:16 (-0800) David Symonds writes:
>On Feb 13, 2008 5:39 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
>> 1) git-branch -d <branchname> complains if <branchname> hasn't been
>> merged to HEAD. Shouldn't it really only complain if <branchname>
>> hasn't been merged into any local branch? i.e., as long as
>> <branchname> has been merged, why care to which branch?
>
>It's easy to mistype branch names, and you typically only delete them
>after you merge them into your current branch. If you're really sure,
>just pass -D instead of -d.

How does that answer the question posed?


Bill
