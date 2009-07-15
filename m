From: Steven Noonan <steven@uplinklabs.net>
Subject: Re: Git/Terminal issue
Date: Wed, 15 Jul 2009 04:51:58 -0700 (PDT)
Message-ID: <alpine.LNX.2.00.0907150450290.14159@xerxes.uplinklabs.net>
References: <24495974.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: GleMarS <glen@erskinedesign.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 13:52:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR327-00066m-GV
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 13:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459AbZGOLvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 07:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754453AbZGOLvk
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 07:51:40 -0400
Received: from mail-pz0-f197.google.com ([209.85.222.197]:34668 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445AbZGOLvj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 07:51:39 -0400
Received: by pzk35 with SMTP id 35so1974424pzk.33
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 04:51:39 -0700 (PDT)
Received: by 10.142.155.8 with SMTP id c8mr1809301wfe.130.1247658697258;
        Wed, 15 Jul 2009 04:51:37 -0700 (PDT)
Received: from Xerxes (donobi-22-18.ra.donobi.net [64.113.22.18])
        by mx.google.com with ESMTPS id 22sm13852011wfg.27.2009.07.15.04.51.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Jul 2009 04:51:36 -0700 (PDT)
In-Reply-To: <24495974.post@talk.nabble.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123301>

On Wed, 15 Jul 2009, GleMarS wrote:

> 
> Hi,
> 
> I'm getting rage. Basically whenever I navigate to a folder that contains a
> .git folder in Terminal (os x leopard), it prints a load of usage text. it's
> driving me mad, I've uninstalled - re-installed etc etc and no joy.
> 
> I have set up git on other machines without any issue so I'm baffled. Output
> image attached.
> 
> Help appreciated.
> 
> http://www.nabble.com/file/p24495974/terminal_low.jpg 

Hi there,

Do you use some kind of special .bashrc, .profile, or other dotfiles that 
would affect what commands such as 'cd' do (i.e. aliases, etc)?

- Steven
