From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2 4/4] diff.c: convert builtin funcname patterns to non-GNU
 extended regex syntax
Date: Tue, 23 Sep 2008 19:04:40 -0500
Message-ID: <qzJgAPRiQZfGnPgFs3xqeXM_jkaODH54dU-hZgP_AftxmMjJxFOfyQ@cipher.nrlssc.navy.mil>
References: <7vskry1485.fsf@gitster.siamese.dyndns.org> <4i0Mu795rKpv37JoHytmE6kODBjwgwITn0-DuKdZiFs3ZnUlyJC-Fw@cipher.nrlssc.navy.mil> <7v7i97swv3.fsf@gitster.siamese.dyndns.org> <7vy71n482x.fsf@gitster.siamese.dyndns.org> <loom.20080920T200157-713@post.gmane.org> <7vmyi21mf8.fsf@gitster.siamese.dyndns.org> <i-l9YX2TO45e2OB9LuoxrAN6a2iFYaH_eEGlVmRsP0oa97XuwX4eGQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 02:06:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiHtK-00006g-5b
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 02:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782AbYIXAEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 20:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754871AbYIXAEw
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 20:04:52 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47739 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754187AbYIXAEv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 20:04:51 -0400
Received: by mail.nrlssc.navy.mil id m8O04eml009457; Tue, 23 Sep 2008 19:04:40 -0500
In-Reply-To: <i-l9YX2TO45e2OB9LuoxrAN6a2iFYaH_eEGlVmRsP0oa97XuwX4eGQ@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 24 Sep 2008 00:04:40.0661 (UTC) FILETIME=[240B7850:01C91DD9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96613>

Brandon Casey wrote:

> I'll do some testing on non-GNU platforms today.

Well, all I've done is compile, and it compiles and runs the
tests correctly. Thought I'd let you know I did at least that.

-brandon
