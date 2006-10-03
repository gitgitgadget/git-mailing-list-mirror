From: "Alan Chandler" <alan@chandlerfamily.org.uk>
Subject: Re: [PATCH] gitweb: document webserver configuration for common
  gitweb/repo URLs.
Date: Tue, 03 Oct 2006 14:35:24 +0100
Message-ID: <E1GUkQe-0007qU-AN@home.chandlerfamily.org.uk>
References: <20061003080328.GI2871@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 15:36:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUkQi-0004aR-PR
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 15:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWJCNf0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 09:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWJCNf0
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 09:35:26 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:48045
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S932080AbWJCNfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 09:35:25 -0400
Received: from alan by home.chandlerfamily.org.uk with local (Exim 4.63)
	(envelope-from <alan@chandlerfamily.org.uk>)
	id 1GUkQe-0007qU-AN; Tue, 03 Oct 2006 14:35:24 +0100
In-Reply-To: <20061003080328.GI2871@admingilde.org>
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28272>

Martin Waitz writes: 

> Add a small apache configuration which shows how to use apache
> to put gitweb and GIT repositories at the same URL. 
> 
 

It might be helpful to include 

SetEnv GITWEB_CONFIG /etc/gitweb.conf 

in that little apache snippet, to show how specify a config file for gitweb. 

 

 --
Alan Chandler
alan@chandlerfamily.org.uk
(via webmail - normally means I am not at my computer)
