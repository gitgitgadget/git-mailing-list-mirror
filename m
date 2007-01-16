From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: sha-1 mismatch using command line sha1sum
Date: Tue, 16 Jan 2007 14:18:54 +0000
Message-ID: <200701161418.55941.andyparkins@gmail.com>
References: <200701161342.56431.andyparkins@gmail.com> <2faad3050701160550g2d3fdf56p64b8ae1ea4d4197e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 16 15:19:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6p9W-0003Kh-Vm
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 15:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbXAPOTE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 09:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbXAPOTE
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 09:19:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:39642 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbXAPOTB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 09:19:01 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1683688uga
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 06:19:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jR3FUGMt6O1IJTep+2uw1FbaUO48kPdWwkcgO8bak2UwhzLT/YeyN5Vz02Aljij7vIMpHfQ9sVEQagtnIyjtNtpQjUqXaLKzvfvozr/Ynh6UTVhrwTM/RaPPNjWPMcoP1csOXl2stINKeOHG/2Mv2QhbncpQ7uaQoNs+cV3QGYk=
Received: by 10.66.244.11 with SMTP id r11mr7560575ugh.1168957139908;
        Tue, 16 Jan 2007 06:18:59 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id l40sm7104439ugc.2007.01.16.06.18.58;
        Tue, 16 Jan 2007 06:18:58 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <2faad3050701160550g2d3fdf56p64b8ae1ea4d4197e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36940>

On Tuesday 2007 January 16 13:50, Baz wrote:

> That changed some time ago. From the git(7) manpage:

Oh good.  I have to admit, I started sweating a bit at the thought that the 
hashes might be wrong :-)  I should know better; git is infalliable :-)


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
