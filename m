From: "Steve Hoelzer" <shoelzer@gmail.com>
Subject: [PATCH] Edit user manual for grammer.
Date: Tue, 12 Jun 2007 07:18:16 -0500
Message-ID: <588192970706120518p201b52fdi9ed48896278b9f3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 14:18:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy5KL-0002Cb-6H
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 14:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518AbXFLMSS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 08:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754531AbXFLMSS
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 08:18:18 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:29355 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518AbXFLMSR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 08:18:17 -0400
Received: by an-out-0708.google.com with SMTP id d31so456486and
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 05:18:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=L9pGrT/GR24glWCyX3xwdZv0BzxzbJlv0yIna8gsQ/PkuxRrGQAwe2RdzanJo50OiAGRzMcjQDqal22D5g9nClgfGCp0QnPWhEoSbAkCW6XuZHoFP6YbiIoc0WFZ5UsFuFzu5oeGe4VR6ymJbn17U1lUlzb/N8zZaCafSx4BC/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dpEwb2nZybnEe7MAvur642NzssB1pqZjU98AWFzYZ7mhmeIy6lCGspvolTWhBTZT1rxG3o5q9OBGQe8xmQCZkIuf1ohScUwM5qjE9phdvLMLrGBg2iUq1w1k1RbGHKXJB/PjALsgTb7x1xvGW/6k8U3HQLawZPOb7DXyzmRvZ8s=
Received: by 10.100.213.3 with SMTP id l3mr3921722ang.1181650697054;
        Tue, 12 Jun 2007 05:18:17 -0700 (PDT)
Received: by 10.100.120.18 with HTTP; Tue, 12 Jun 2007 05:18:16 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49952>

Signed-off-by: Steve Hoelzer <shoelzer@gmail.com>
---
 Documentation/user-manual.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 0bfa21b..68bf4e2 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1529,7 +1529,7 @@ dangling tree b24c2473f1fd3d91352a624795be026d64c8841f

 Dangling objects are not a problem.  At worst they may take up a little
 extra disk space.  They can sometimes provide a last-resort method of
-recovery lost work--see <<dangling-objects>> for details.  However, if
+recovering lost work--see <<dangling-objects>> for details.  However, if
 you want, you may remove them with gitlink:git-prune[1] or the --prune
 option to gitlink:git-gc[1]:

--
1.5.2.73.g18bece
