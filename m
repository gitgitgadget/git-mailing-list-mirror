From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 3/4] gitk-git/Makefile: track TCLTK_PATH as it used
 to be tracked
Date: Tue, 18 Dec 2012 16:12:04 +0100 (CET)
Message-ID: <20121218.161204.548712704436812637.chriscool@tuxfamily.org>
References: <20121217071716.26209.54407.chriscool@tuxfamily.org>
	<7vvcc1m8t9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 18 16:12:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkyqI-0000cr-QE
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 16:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914Ab2LRPMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 10:12:08 -0500
Received: from mail-1d.bbox.fr ([194.158.122.56]:36965 "EHLO mail-1d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754874Ab2LRPMH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 10:12:07 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1d.bbox.fr (Postfix) with ESMTP id 0D533EF;
	Tue, 18 Dec 2012 16:12:05 +0100 (CET)
In-Reply-To: <7vvcc1m8t9.fsf@alter.siamese.dyndns.org>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211751>

From: Junio C Hamano <gitster@pobox.com>
>
>>  .gitignore          |  1 -
>>  gitk-git/.gitignore |  2 ++
>>  gitk-git/Makefile   | 16 ++++++++++++++--
> 
> I'll apply the .gitignore part to my tree, but could you split the
> rest out and have Paul apply to his tree at
> 
>     git://ozlabs.org/~paulus/gitk.git

Ok, I just sent the rest to Paul and I am going to send you an updated
series for you.

Regards,
Christian.
