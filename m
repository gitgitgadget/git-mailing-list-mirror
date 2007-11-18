From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git User's Survey 2007 summary at GitWiki
Date: Sun, 18 Nov 2007 11:39:53 +0100
Message-ID: <200711181139.54466.jnareb@gmail.com>
References: <200711160302.59786.jnareb@gmail.com> <200711181127.09385.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 11:40:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IthZn-0003Qt-0S
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 11:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbXKRKkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 05:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbXKRKkJ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 05:40:09 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:64691 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbXKRKkH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 05:40:07 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1496640fkz
        for <git@vger.kernel.org>; Sun, 18 Nov 2007 02:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=j5CLBokvBu/1n4/J5CuZUf6E0pPyK4n6FPjO1WID9M4=;
        b=VGpVoXiNrnja2oxpY6gZEtJgWhLKTwCL8BRRwOitStuBGnqRFX0JmJllHmK74ZYaI4fvwL+lUTkHpWdhiy9sIAIGVqZV9UAczQKiB4iJ+qxQlf8gNYuEg88X1avtJkcQq+r1Pxk8IzeaINxSSkNb9/Ig/OFkkxAEQoFkPtdjtVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uDouaK8sOnxpP3d5wqGvmjAP4PLStjLo8ncx1v+djxcZjxdbIs7tx13IR+0IyMYgOqGpoj2dU33wTyeSyZOfmYxzbSfwhqAspMQRRtiuiTJDq5Slqd7dmpY6aqi4zQzEuROyaYnBMqD932nKaG2Vvs39WNLYchaaPfyP09caW/I=
Received: by 10.86.99.9 with SMTP id w9mr3840691fgb.1195382404495;
        Sun, 18 Nov 2007 02:40:04 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.208.67])
        by mx.google.com with ESMTPS id e20sm5335839fga.2007.11.18.02.40.01
        (version=SSLv3 cipher=OTHER);
        Sun, 18 Nov 2007 02:40:02 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200711181127.09385.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65363>

On Sun, Nov 18, 2007, Robin Rosenberg wrote:
> fredag 16 november 2007 skrev Jakub Narebski:

>> I'd like to announce that summary of Git User's Survey 2007 is now 
>> present on Git Wiki at
>> 
>>   http://git.or.cz/gitwiki/GitSurvey2007
>> 
>> 
>> P.S. There are still few questions for which there are not full 
>> analysis, or are not analized at all.
> 
> Comments to some comments:
>
>> I wonder what are those 15 other GUI. Why oh why there were no
>> "What is this 'other GUI'?" question... 
> 
> I know I checked "other", which in my case meant The Eclipse Plugin.

The Eclipse Plugin was removed from the GUI list on request from someone 
at git mailing list during an RFC phase for survey questions. Egit is
neither fish nor fowl: it looks like GUI, but it is more than just
a porcelain; it is implementation of git in Java.

I think I should have put it among porcelains 
  "26. Which porcelains do you use?"


I definitely should have added 'what other' for each single chioce / 
multiple choice question where 'other' was one of possible answers. 
Ehh...

-- 
Jakub Narebski
Poland
