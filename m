From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Adding spell checker to GIT
Date: Tue, 16 Jan 2007 17:10:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701161709570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <b5a19cd20701041246we052685hd700580df2cc120d@mail.gmail.com> 
 <Pine.LNX.4.63.0701052147070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <b5a19cd20701051921j69f1a85bo97e39db7d8401222@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 17:10:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6qtZ-0004T2-QW
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 17:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbXAPQKh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 11:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbXAPQKh
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 11:10:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:42996 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751293AbXAPQKh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 11:10:37 -0500
Received: (qmail invoked by alias); 16 Jan 2007 16:10:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 16 Jan 2007 17:10:35 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Deepak Barua <dbbarua@gmail.com>
In-Reply-To: <b5a19cd20701051921j69f1a85bo97e39db7d8401222@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36946>

Hi,

On Sat, 6 Jan 2007, Deepak Barua wrote:

> Hi Johannes,
>                    I spell check "//" comments in
> in find_ext()
> 
> if($_[0] =~ /\.cc|\.java/) {
> 
>                $start_pattern  = qr!\s/\*\s|\s//\s!;
>        }
> 
> and
> 
> $chosen_pattern eq qq!\s//\s! ? $end_pattern=qq!\s\014\s! : "End
> Pattern Not Found" ;
> 
> Also yes i didnt include to use spell checking in string literals , i
> thought that would be irregular and cumbersome.
> 
> Could you please test the code then i can include it in a seperate file ..?

Sorry, I am a little bit stressed at the moment... And I don't have the 
required dependencies installed.

Ciao,
Dscho
