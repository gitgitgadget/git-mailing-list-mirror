From: "Jonathan Trites" <tritesnikov@gmail.com>
Subject: Deleting branches in cogito
Date: Fri, 5 Jan 2007 04:29:59 -0600
Message-ID: <11935db10701050229h215416afk9ac2008c4f176b36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jan 05 11:30:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2mKv-00064p-6B
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 11:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbXAEKaE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 05:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbXAEKaB
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 05:30:01 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:54418 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161048AbXAEKaA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 05:30:00 -0500
Received: by wx-out-0506.google.com with SMTP id h27so7048386wxd
        for <git@vger.kernel.org>; Fri, 05 Jan 2007 02:29:59 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=psfwOyD7ki0RDMQSU+AoH9ZafTchhlkeDnuj5TUYuVruplLs8RtnA7xQJnVYwKeAVfds/hmYxX8yImlu+PgzB3+W+dVFRU9bp2YbXi7O7YN1LVRSnaLjDa1Bbaf+fuqKzzY7ysfnBm0GtJqexP8SDkQNziqFhVZHJjj9Z1Di1/U=
Received: by 10.90.98.10 with SMTP id v10mr633675agb.1167992999900;
        Fri, 05 Jan 2007 02:29:59 -0800 (PST)
Received: by 10.90.100.7 with HTTP; Fri, 5 Jan 2007 02:29:59 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35990>

Forgive my brain damage, but how does one go about deleting branches
in cogito? I've been up and down google and the mailing lists and I
can't find any mention of how one does this.

I see there are commands cg-switch, cg-branch-add, cg-branch-chg, and
cg-branch-ls, but nowhere do I see a "cg-branch-rm" command or
equivalent cg-switch command line option.

In the git commands I see "git-branch -d", and maybe this is the
command I am looking for, but is there a "native" cogito command to
delete branches?
