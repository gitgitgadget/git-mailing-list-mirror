From: opticyclic <opticyclic@gmail.com>
Subject: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of Pull Requests
Date: Wed, 29 Feb 2012 12:19:45 -0500
Message-ID: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 29 18:19:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2nBx-0007eZ-7X
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 18:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758212Ab2B2RTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 12:19:46 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46857 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757989Ab2B2RTq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 12:19:46 -0500
Received: by vcqp1 with SMTP id p1so3541249vcq.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 09:19:45 -0800 (PST)
Received-SPF: pass (google.com: domain of opticyclic@gmail.com designates 10.52.91.196 as permitted sender) client-ip=10.52.91.196;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of opticyclic@gmail.com designates 10.52.91.196 as permitted sender) smtp.mail=opticyclic@gmail.com; dkim=pass header.i=opticyclic@gmail.com
Received: from mr.google.com ([10.52.91.196])
        by 10.52.91.196 with SMTP id cg4mr1421880vdb.68.1330535985237 (num_hops = 1);
        Wed, 29 Feb 2012 09:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=hm5spjhRVVwaJIsNdeUvpPDzCumM3pv5tgX75QjWMdg=;
        b=j0dgeh0yrhkN2vhvAzXpapFV8kGsGsSlBujTQmPUh0/Eo54LRhCn6udZmIrj24uZBd
         IWV07iCxdxvurGxsuJqrCAo1aYuyYNWFgP+F33KIxAfrJ++WmQb3b11vjXzmGSWbSszI
         gd8AYxC13J0A1ohxscgazuTWvQH4xSX10aXro=
Received: by 10.52.91.196 with SMTP id cg4mr1200758vdb.68.1330535985199; Wed,
 29 Feb 2012 09:19:45 -0800 (PST)
Received: by 10.52.66.238 with HTTP; Wed, 29 Feb 2012 09:19:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191835>

Firstly, why is there no Bug Tracker such as JIRA for the git project?
This mailing list is next to useless for users since searching is
difficult, as is commenting and voting.

Secondly, since one of the alleged reasons for creating git was to not
have to deal with patches, why are pull requests disable and patches
sent to this mailing list?!
I have read https://github.com/gitster/git/blob/master/Documentation/SubmittingPatches
and it doesn't explain it.

I'm sure I don't have to tell you that GitHub has discussions on pull
requests, which are easier to view than the mailing list archives.

So why is it done in the current way?
