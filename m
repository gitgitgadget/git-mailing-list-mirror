From: "Alex Bennee" <kernel-hacker@bennee.com>
Subject: Adding Reviewed-by/Tested-by tags to other peoples commits
Date: Sat, 11 Oct 2008 07:37:04 +0100
Message-ID: <b2cdc9f30810102337q13432bepa957acaace9ddc5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 11 08:41:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoYA3-0006pP-48
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 08:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756043AbYJKGju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 02:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756578AbYJKGjs
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 02:39:48 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:8900 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309AbYJKGhG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 02:37:06 -0400
Received: by yw-out-2324.google.com with SMTP id 9so277626ywe.1
        for <git@vger.kernel.org>; Fri, 10 Oct 2008 23:37:05 -0700 (PDT)
Received: by 10.90.106.1 with SMTP id e1mr2824445agc.42.1223707024334;
        Fri, 10 Oct 2008 23:37:04 -0700 (PDT)
Received: by 10.90.105.11 with HTTP; Fri, 10 Oct 2008 23:37:04 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 6934f162a838629d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97965>

HI,

I've just tested/reviewed a patch of someone elses and I want to
forward it on the appropriate mailing list. I gather for Linux you
just add the appropriate tags to the commit. Does git offer a shortcut
for doing this or do you have to do a reset HEAD^ and re-commit with a
copy&pasted and modified commit message?

Or does everyone have their own magic scripts for tagging commits
during reviews?

-- 
Alex, homepage: http://www.bennee.com/~alex/
