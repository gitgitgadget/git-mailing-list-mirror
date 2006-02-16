From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: git faq : draft and rfc
Date: Thu, 16 Feb 2006 07:50:20 +0000
Message-ID: <200602160750.20500.alan@chandlerfamily.org.uk>
References: <22e91bb0602151636r2e70e60cpa5038f4b6caccc9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Feb 16 08:50:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9duJ-00048Z-Dp
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 08:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWBPHuP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 02:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWBPHuO
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 02:50:14 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:61355
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S932507AbWBPHuN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 02:50:13 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1F9du0-0008Gg-L4
	for git@vger.kernel.org; Thu, 16 Feb 2006 07:50:12 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <22e91bb0602151636r2e70e60cpa5038f4b6caccc9c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16278>

On Thursday 16 February 2006 00:36, Thomas Riboulet wrote:
> . What's the difference between fetch and pull ?
> Fetch : download objects and a head from another repository.
> Pull : pull and merge from another repository.
> See man git-fetch and git-pull for more.

Surely you are using a pull to mean fetch here,  Shouldn't this be

Fetch: download objects and a head from another repository.
Pull: fetch (as defined above) and then merge this with current development

or something

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
