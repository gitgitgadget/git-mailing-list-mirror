From: Rutger Nijlunsing <rutger.nijlunsing@gmail.com>
Subject: Re: Git for Windows 1.6.2-preview20090308
Date: Mon, 9 Mar 2009 11:34:14 +0100
Organization: M38c
Message-ID: <20090309103414.GA5247@wingding.demon.nl>
References: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de>
Reply-To: rutger.nijlunsing@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Mar 09 11:35:59 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.24])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgcpp-0005Cz-K4
	for gcvm-msysgit@m.gmane.org; Mon, 09 Mar 2009 11:35:49 +0100
Received: by yw-out-2122.google.com with SMTP id 1so971338ywp.63
        for <gcvm-msysgit@m.gmane.org>; Mon, 09 Mar 2009 03:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :organization:user-agent:x-virus-scanned:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=r5PS3h6gSB54INaT6rqBkPnhIVrE52hhapQD2IIFUn8=;
        b=O2RNWrlqxN/MEEnNcnLI7tjmxRKqAB6OYGrN1eej3ibGRYzwUjGTZCcEJu5EP/Z4mB
         lWordp8KMpc9i6IfxmY5VNjan5z1uk6pH8bLJHDuTb9RwTMtebAboNAaS8nh3nJlh0H9
         IbJ9yX6zaoeWQvpJzkzTvOZvZ3dq5KmGUVf5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date
         :from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:organization
         :user-agent:x-virus-scanned:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=hmPMkn1X2Kfznodl123dktGHloX4wiKIeYHC47Vc50HMSXkJK/vcyS78fiCcNfFMIK
         vytKD4J4mWrdTdfAWNqc9sC5+AmIaQccagumNAtXi9mQR0QGmjIs2qCEiOpTwDgxYILR
         Abg/QBoTXionl1pYr4y0qWPeYRYMK/Me5sQoU=
Received: by 10.100.43.10 with SMTP id q10mr932158anq.15.1236594856590;
        Mon, 09 Mar 2009 03:34:16 -0700 (PDT)
Received: by 10.177.145.19 with SMTP id x19gr3902yqn.0;
	Mon, 09 Mar 2009 03:34:16 -0700 (PDT)
X-Sender: rutger@wingding.demon.nl
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.120.17 with SMTP id s17mr325913ebc.3.1236594855969; Mon, 09 Mar 2009 03:34:15 -0700 (PDT)
Received: from smtp-vbr8.xs4all.nl (smtp-vbr8.xs4all.nl [194.109.24.28]) by gmr-mx.google.com with ESMTP id 14si505917ewy.5.2009.03.09.03.34.15; Mon, 09 Mar 2009 03:34:15 -0700 (PDT)
Received-SPF: neutral (google.com: 194.109.24.28 is neither permitted nor denied by best guess record for domain of rutger@wingding.demon.nl) client-ip=194.109.24.28;
Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 194.109.24.28 is neither permitted nor denied by best guess record for domain of rutger@wingding.demon.nl) smtp.mail=rutger@wingding.demon.nl
Received: from wingding.demon.nl (wingding.demon.nl [82.161.27.36]) by smtp-vbr8.xs4all.nl (8.13.8/8.13.8) with ESMTP id n29AYESS008954 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO); Mon, 9 Mar 2009 11:34:15 +0100 (CET) (envelope-from rutger@wingding.demon.nl)
Received: from rutger by wingding.demon.nl with local (Exim 4.69) (envelope-from <rutger@wingding.demon.nl>) id 1LgcoI-0005Cf-Oq; Mon, 09 Mar 2009 11:34:14 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112685>


On Sun, Mar 08, 2009 at 02:10:21AM +0100, Johannes Schindelin wrote:
> 
> Hi,
> 
> I just released a new version of Git for Windows (TAFKA WinGit).  It is 
> basically Git 1.6.2 plus a few patches.  Please find the installer here:
> 
> 	http://msysgit.googlecode.com/
> 
[snip]
> Changes since Git-1.6.1-preview20081225
> 
> Bugfixes
> - Comes with updated msys-1.0.dll (should fix some Vista issues).

Thanks! This also fixes the 'git hangs 5s without any reason on some
Windows XP machines'!


-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
