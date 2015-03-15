From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: Re: fatal: Unable to mark file .ruby-version
Date: Sun, 15 Mar 2015 20:51:50 +0630
Organization: CognitiveClouds
Message-ID: <7217253.Nyz2WfkBbo@linux-wzza.site>
References: <1645103.91WotSCBpm@linux-wzza.site> <20150315123004.GB12619@hank>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 15 16:30:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXAUm-00035b-IJ
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 16:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbbCOPaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 11:30:24 -0400
Received: from nm19-vm2.bullet.mail.sg3.yahoo.com ([106.10.149.113]:52249 "EHLO
	nm19-vm2.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752545AbbCOPaX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Mar 2015 11:30:23 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Mar 2015 11:30:22 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1426433050; bh=dx9yPYTw/LeW8eXUyWax5Dai9RKOsOV2GJ0s12G7MH4=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject; b=ZayL7dmODytSPp+qAlX+Qc/nBfTMdEDcrQmK5Qbnh/IlVRx0RpxEyzNtnxusqP820fiLMzLRJqqcU5x2gSltMeDUu+WfTf7n2UbiKo/T0z1X94Zm0bb19REESqKdtJWMR4F1DuZBpQKamhaiN/5Hewd6VyrUWUhmWY0oHW2miGDdNBKjcD9Xzm9xO1p+3qjE9JpHx1Oz4Mu6bub00hPOAd7WKah2dy/zHH4+LQGJdrigXZLTu9KfvruuV9Ds3j+DlYyh0nIAMCpyEhg2RKJWpHgRP5Rgh9BqadEzI7Z1DOKOEx+r9+Xo2X/haFniIwcXRtotBEg7KIAlPLwNRiiiqg==
Received: from [106.10.166.116] by nm19.bullet.mail.sg3.yahoo.com with NNFMP; 15 Mar 2015 15:24:10 -0000
Received: from [106.10.167.172] by tm5.bullet.mail.sg3.yahoo.com with NNFMP; 15 Mar 2015 15:24:10 -0000
Received: from [127.0.0.1] by smtp145.mail.sg3.yahoo.com with NNFMP; 15 Mar 2015 15:24:10 -0000
X-Yahoo-Newman-Id: 50119.14746.bm@smtp145.mail.sg3.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: LzGPws4VM1mC1eyMyMwuceg.048swTE1uClCWhj3E2yuzQI
 DL3_cxUHhMKe1r3BUBpaJUYIuMcWUzlt7217dhsIXm29EZ7JRSPyIaqmWNLJ
 4RYmSdxqEaDkYKsxEPDAbabtLbBR5BDEjrpnSXm6I0SF0e4V034TMYwTO_XZ
 iN2R3.cGUFQJqNlsNb.V9JHbd9XcPFD9sjwr109vwfAXcLN0dblTR3B.5MGK
 CNHJoGQbN9qB5NnQv0JzgZKf5dlvucZQJLku9Y8V4Q8jCLywgI3acPXc4Z5W
 om23Ijc6sY.OM8q5I9xPNByXacca9dmxQ8ro5UeZZQLL8iiSwlXUCR9hXlyp
 eXnyScdnEPRVXmk5PtH3gCQHfRC94KMVooX.ZOWjop5jLNh29lxR_HGl.fqn
 iXOLp5XnS2PCDJ8gqpbMtdJcmKMr3z9tWWH0AH_R9_Ri_YJYzCpL7MgSiNQu
 OhEoty8QkBQk7RqqxcuQrv5djOq47Y.Vz9UF24ubxVgSa5PS1GytbeGbpSTo
 iQzKKm4k885XX19rKGXSWdbIqmntVvgrQvZu18H_sr_hg1eGxszhZ1.i1Vzt
 AKxolR7pg
X-Yahoo-SMTP: _NAuC72swBDpdridK5c7mltfXc1K.nFhPY5jXEZ4Gfdya8Gn_0nN
User-Agent: KMail/4.11.5 (Linux/3.11.10-25-default; KDE/4.11.5; i686; ; )
In-Reply-To: <20150315123004.GB12619@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265496>

On Sunday, March 15, 2015 01:30:04 PM you wrote:
> Hi,
> 
> On 03/15, Arup Rakshit wrote:
> > Hi,
> > 
> > I am trying to ignore 2 files, but getting error -
> > 
> > [arup@sztukajedzenia (SJ002)]$ git status
> > # On branch SJ002
> > # Untracked files:
> > #   (use "git add <file>..." to include in what will be committed)
> > #
> > #       .ruby-gemset
> > #       .ruby-version
> > nothing added to commit but untracked files present (use "git add" to track)
> > [arup@sztukajedzenia (SJ002)]$ git update-index --assume-unchanged .ruby-gemset
> > fatal: Unable to mark file .ruby-gemset
> > [arup@sztukajedzenia (SJ002)]$ git update-index --assume-unchanged .ruby-version
> > fatal: Unable to mark file .ruby-version
> > [arup@sztukajedzenia (SJ002)]$
> 
> With --assume-unchanged you're promising git that you will not change
> a file that is already in the repository.  Git doesn't check those
> files for changes anymore, which can improve performance.
> 

I didn't understand your point. Could you please elaborate more on it ?

> > Why it is throwing error ? And how to achieve this without taking
> > the help of the file `.gitignore` ?
> 
> You can create a file .git/info/exclude in the root directory of the
> repository with the same syntax as .gitignore to ignore these files.
> This rules will not be commited in the repository.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
================
Regards,
Arup Rakshit
================
Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it.

--Brian Kernighan
