From: Jakub Narebski <jnareb@gmail.com>
Subject: If you would write git from scratch now, what would you change?
Date: Sun, 25 Nov 2007 22:48:27 +0100
Message-ID: <200711252248.27904.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 25 22:48:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwPLN-0004je-3T
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 22:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755428AbXKYVsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 16:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752905AbXKYVsa
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 16:48:30 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:50594 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773AbXKYVsa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 16:48:30 -0500
Received: by nf-out-0910.google.com with SMTP id g13so480088nfb
        for <git@vger.kernel.org>; Sun, 25 Nov 2007 13:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=LgCAcZ8Kzaucg/lwwABR6LGIPHd3K2rj3W7Ugwa87v8=;
        b=d4YglYSws8P6rM6WX+h/u5zTpM/hYecdG7v46UJBBEoKcVbfixxiItLOCWnk7itkE11qRY0RyKeDzHPXbEXQ4n5Zw+/PAZhSuYpR5Cl8uvyPKhsGCXLbagn6tseZ4Gxv3pAw1FqMgcc41HMP5BMZ66BTYsMvwO1h/8J96QUUcvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=O5agNV/iU6jfmnpS4xvfaCiN4TQIYhMZs7eNiAIguzILtp4Yxqt4z87w1LOgL6cVEJutWoawtfug6fVE4QtEHZBD7TLQpF/eYZl8SZ10De3J7Et97V7cZBFyFDYaGzpsn26nky4wpTWi4WJ5dSkvE+5J9WA4q1bUy7goe1m1maM=
Received: by 10.86.100.7 with SMTP id x7mr1948564fgb.1196027308003;
        Sun, 25 Nov 2007 13:48:28 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.223.27])
        by mx.google.com with ESMTPS id d6sm1357418fga.2007.11.25.13.48.26
        (version=SSLv3 cipher=OTHER);
        Sun, 25 Nov 2007 13:48:27 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66013>

If you would write git from scratch now, from the beginning, without 
concerns for backwards compatibility, what would you change, or what 
would you want to have changed?


Yes, I know, I know. "Worse is better". It is better to release early 
and get feedback what is really needed, as opposed to what do you think 
is needed.

I think git is a wonderful example of "evolved" software, evolving 
practically from the very beginnings.

-- 
Jakub Narebski
Poland
