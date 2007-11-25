From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: Git Screencast ?
Date: Sun, 25 Nov 2007 18:43:26 +0100
Message-ID: <20071125174325.GA2402@dualtron.vpn.rwth-aachen.de>
References: <fi1a9f$30q$1@ger.gmane.org> <47453C6D.1080403@op5.se> <fi5bet$brl$1@ger.gmane.org> <20071123101426.GA15902@dualtron.vpn.rwth-aachen.de> <20071123205825.GB14735@spearce.org>
Reply-To: Johannes Gilger <heipei@hackvalue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: Michael Donaghy <mike@mikedonaghy.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Nov 25 18:44:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwLWQ-0004Bj-SC
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 18:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357AbXKYRnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 12:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbXKYRnj
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 12:43:39 -0500
Received: from avalon.gnuzifer.de ([85.10.199.84]:39564 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196AbXKYRnj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 12:43:39 -0500
Received: from 0-209.vpn.rwth-aachen.de ([134.130.240.209]:60236 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <heipei@hackvalue.de>)
	id 1IwLVz-0005X6-BY; Sun, 25 Nov 2007 18:43:32 +0100
Mail-Followup-To: "Shawn O. Pearce" <spearce@spearce.org>,
	Michael Donaghy <mike@mikedonaghy.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071123205825.GB14735@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-SA-Exim-Connect-IP: 134.130.240.209
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65975>

On 23/11/07 15:58, Shawn O. Pearce wrote:
> Actually some users have found that its easier to grok the index
> by using git-gui.  You can more directly see the state of update
> actions, and it is fairly easy to stage/unstage individual hunks
> of files through git-gui.  Once you get that down then seeking
> the same methods through the command line isn't too difficult,
> many of the terms in git-gui are the same as the command line term,
> to make the transition back and forth easier for the user.

It seems that I myself did not realize what a good tool git-gui is. I 
started using git with the command line and so far have rarely needed to 
stage individual hunks (or explain the git principles to anyone). I did 
use gitk to visualize history (especially branches) though.

So, to sum it up, yeah, git-gui is a good way to find your way into git. 
After some time you realize yourself when to use the gui and when to 
stick to the command line.

Greetings,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
