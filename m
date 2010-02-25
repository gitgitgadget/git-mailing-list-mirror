From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Roadmap to better handle big files?
Date: Thu, 25 Feb 2010 11:06:10 -0700
Message-ID: <4B86BC12.9080201@workspacewhiz.com>
References: <B85968F5-E7C2-499D-A8BE-0160BA575F10@perceptivepixel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nick Triantos <nick@perceptivepixel.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 19:13:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkiCr-0007CK-3d
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 19:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933030Ab0BYSMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 13:12:55 -0500
Received: from hsmail.qwknetllc.com ([208.71.137.138]:53880 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932876Ab0BYSMz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 13:12:55 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Feb 2010 13:12:55 EST
Received: (qmail 8045 invoked by uid 399); 25 Feb 2010 11:06:12 -0700
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.231.4.206)
  by hsmail.qwknetllc.com with ESMTPAM; 25 Feb 2010 11:06:12 -0700
X-Originating-IP: 75.231.4.206
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.8) Gecko/20100216 Lightning/1.0b2pre Thunderbird/3.0.2
In-Reply-To: <B85968F5-E7C2-499D-A8BE-0160BA575F10@perceptivepixel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141061>

----- Original Message -----
From: Nick Triantos
Date: 2/24/2010 4:00 PM
> Is there any planned functionality to better support large files in git?  (>  100MB / file)
>    
I once used Git alternates to point to a network share filled with the 
really large files hashed into a .git/objects directory.  It worked, 
although it was slower than having the entire repository locally.

Josh
