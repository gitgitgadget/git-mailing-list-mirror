From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: gitpacker progress report and a question
Date: Tue, 27 Nov 2012 02:30:33 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121127073033.GB23169@thyrsus.com>
References: <20121115212818.GA21558@thyrsus.com>
 <CAMP44s30px2FgieC9VcGji7T+yWFo7gMSwQhtuztHrqto8B7Aw@mail.gmail.com>
 <20121126220108.GB1713@thyrsus.com>
 <CAMP44s2+NDyL2Vf=iKR09f-YUnp=G2BCiYj-+qKuP7JA-+YkmQ@mail.gmail.com>
 <20121126234359.GA8042@thyrsus.com>
 <CAMP44s3=VpMv-S2eV9rXRaH9U3SvaR8B6Dto=vAmVQ_XB1uBXg@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 08:30:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdFd4-0001TY-S2
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 08:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758237Ab2K0Hag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 02:30:36 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:54768
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758215Ab2K0Haf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 02:30:35 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 978C540661; Tue, 27 Nov 2012 02:30:33 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAMP44s3=VpMv-S2eV9rXRaH9U3SvaR8B6Dto=vAmVQ_XB1uBXg@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210538>

Felipe Contreras <felipe.contreras@gmail.com>:
> > The main objective of the logfile design is to make hand-crafting
> > these easy.
> 
> Here's another version with YAML:

Clever.  

Now I have to decide if I should allow my aesthetic dislike of YAML to
prevail despite the fact that it's pretty well suited to this job.  There
is definitely a case for applying a standard metaprotocol like YAML (ugh)
or XML (double ugh).
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
