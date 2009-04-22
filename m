From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Wed, 22 Apr 2009 12:24:21 +0100
Message-ID: <B2EB379C-72D6-4318-8873-E82B799F0437@ai.rug.nl>
References: <alpine.LFD.2.00.0904070903020.6741@xanadu.home> <20090407181259.GB4413@atjola.homenet> <alpine.LFD.2.00.0904071454250.6741@xanadu.home> <20090407202725.GC4413@atjola.homenet> <alpine.LFD.2.00.0904080041240.6741@xanadu.home> <20090410T203405Z@curie.orbis-terrarum.net> <alpine.DEB.1.00.0904141749330.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904141542161.6741@xanadu.home> <20090414T202206Z@curie.orbis-terrarum.net> <1240362948.22240.76.camel@maia.lan> <e2b179460904220255v58986bd5q7c22eb3ab8486157@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam@vilain.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Matt Enright <awickedshimmy@gmail.com>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 13:26:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwaan-0003Cm-Q3
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 13:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbZDVLYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 07:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbZDVLYo
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 07:24:44 -0400
Received: from frim.nl ([87.230.85.232]:38746 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751383AbZDVLYo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2009 07:24:44 -0400
Received: from 82-41-227-224.cable.ubr11.sgyl.blueyonder.co.uk ([82.41.227.224] helo=[192.168.50.100])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1LwaZ8-0005GU-Nn; Wed, 22 Apr 2009 12:24:34 +0100
In-Reply-To: <e2b179460904220255v58986bd5q7c22eb3ab8486157@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117193>


On 22 apr 2009, at 10:55, Mike Ralphson wrote:

> It's sort of three, really...
>
> http://socghop.appspot.com/student_project/show/google/gsoc2009/mono/t124022708105

That same project was also done by two(!) students last
year, but I don't think that worked out. I wonder how it'll
play out this year.

- Pieter
