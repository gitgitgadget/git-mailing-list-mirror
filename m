From: skillzero@gmail.com
Subject: How do gmail users try out patches from this list?
Date: Tue, 11 Aug 2009 13:43:13 -0700
Message-ID: <2729632a0908111343v73fa475fqb6353dcf2f718101@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 22:43:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MayBm-0002kW-VO
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 22:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbZHKUnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 16:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752633AbZHKUnN
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 16:43:13 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:53091 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbZHKUnM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 16:43:12 -0400
Received: by qyk34 with SMTP id 34so3481355qyk.33
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 13:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=HztmRzjz6vwQUscjkit+GBitN2JHl7Xigd+vTi04Fro=;
        b=jeVTExsz9K0NdamDDLp9nkrOYAPTewNLrbA5zDlCJ3m8mNNij8RFhy5t8piRIk7vyJ
         YTRO3c9FS+LEYO7eGHmNq9Gn3iufrGtZwy9hzX1zgFVV5WFez8F1OyXCjIAU/vDfX8iO
         OS2eOMTBfudP7nNstfj3l7BNB8NbovNw/CLto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Gj61J5WRl+5/4dammALEVRA2CkHPZSkb0zm0kJAQ78VcL1EMEhnfIaH/1dDFh4jOYh
         OcAXfxrk8x4L8cOz1QCzrn3ZGO5wd7LebHEhC9qULqyoI96Bc5qo8pBfLSsiOqKUW+XU
         uaj5bg0pKMJ4GAPYwEI39n5HT5WpBormjbMP8=
Received: by 10.224.19.207 with SMTP id c15mr4482768qab.69.1250023393526; Tue, 
	11 Aug 2009 13:43:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125591>

Sorry if this is dumb question, but I didn't see any good info in my searches.

How do gmail users normally apply patches that come through the list?
Do you just manually copy and paste the email to patch files and use
git apply? Do you use a tool to export to mbox files and use git am?

I've been just doing it manually via copy and paste, but it's kinda tedious.
