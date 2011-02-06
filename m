From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [idea] Re: separate .git dir and the working tree
Date: Sun, 6 Feb 2011 11:55:10 +0100
Message-ID: <20110206105510.GA14195@vidovic>
References: <AANLkTik4MjnpOzPdGy7ZDiH0in4e1DpjrhQFOHjUiEEE@mail.gmail.com>
 <20110205032339.GA15303@mg1>
 <20110205132708.GA18391@elie>
 <20110206002009.GA13594@mg1>
 <20110206004013.GB13594@mg1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: git@vger.kernel.org, redstun <redstun@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 11:55:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm2H6-0004Mb-Ty
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 11:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099Ab1BFKzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 05:55:18 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59601 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab1BFKzR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 05:55:17 -0500
Received: by wyb28 with SMTP id 28so3667374wyb.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 02:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=81dvATNifiDrp5G+bLa6S1PCZNgXBvLWTXCXUrsRQqw=;
        b=lBbBKPQdH1bqfEKVDKSDD8frHQJH3BazqwqVuY20J+/mQNwxBh8eC0Tw/IHJdNVFZ7
         OvioKG2L2lyMbXVGpGhJ5HcX12OP+LMSV9KHp7dLjNstmo3OyRGIHTkVdB2XsVnWFh44
         3Z73Jbg5OGYTG3e8hZ53tgQI7/8pm5VMelzDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ttQfNEK+oOAIg4M7hNzlCce/UOA0VjpzeGq0plAVG0aFX2Ah7OQUe+VPZByFcVZ4VW
         5qUselPelLSRczLMsh5ca91o82urPCpCc0CRkB/KMB77WbIuOzF3MGGSCmHlzPJzUC7e
         tDnmHAg6HZd1KJ5jknRKAEomXqpbCSWSdWYg0=
Received: by 10.227.155.66 with SMTP id r2mr471704wbw.73.1296989715926;
        Sun, 06 Feb 2011 02:55:15 -0800 (PST)
Received: from vidovic (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id r80sm1487805wei.39.2011.02.06.02.55.13
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 02:55:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110206004013.GB13594@mg1>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166143>

The 05/02/11, Mike Gant wrote:

> So does anyone use Mutt? And do they know a recipe to move the sender
> address to the cc list? If not, I'll figure it out.

g (group answer).

-- 
Nicolas Sebrecht
