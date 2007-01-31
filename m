From: Andy Parkins <andyparkins@gmail.com>
Subject: Qt git repository report
Date: Wed, 31 Jan 2007 09:12:57 +0000
Message-ID: <200701310912.59102.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 10:13:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCBWg-0007he-6q
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 10:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbXAaJNF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 04:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbXAaJNF
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 04:13:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:56586 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932493AbXAaJNE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 04:13:04 -0500
Received: by ug-out-1314.google.com with SMTP id 44so115936uga
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 01:13:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WqGHXUJ1iDmtbYG7NEw5ksV7q6q1KZHvXtOSWL5gbHb1EUY+ZvHdlOmeOoUYq7H5MnHP3eACDHqUPdkSGmKHFdrnMQauJ8Y5ObUmecJ/+1mlwyZg7tQASXCvshcMW273keWht0kyMyk+B9seMo6Fu2TVdHHdDEPSVtoAIsPnbm4=
Received: by 10.66.255.7 with SMTP id c7mr727979ugi.1170234782821;
        Wed, 31 Jan 2007 01:13:02 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id 53sm712744ugn.2007.01.31.01.13.01;
        Wed, 31 Jan 2007 01:13:01 -0800 (PST)
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38236>

Hello,

It's always nice to read positive reports, so I thought I'd point you all at 
this one.

One of the Qt developers posted a blog entry describing the conversion of the 
Qt repository from perforce to git.

http://qtdeveloper.net/archives/2007/01/30/fun-with-git/

Key facts:
 * 13 years worth of changes
 * 94000 revisions
 * 736774 objects
 * Took 3 hours to convert using git-fast-import and a custom script
 * Repository size: 500MB
 * Checkd out tree size: 330MB

I never cease to be amazed by how good git is at its job.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
