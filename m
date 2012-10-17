From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Wed, 17 Oct 2012 18:03:14 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1210171759230.3049@bonsai2>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 18:03:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOW5h-00086h-MJ
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 18:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907Ab2JQQDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 12:03:18 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:57031 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754986Ab2JQQDR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 12:03:17 -0400
Received: (qmail invoked by alias); 17 Oct 2012 16:03:15 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO client.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp033) with SMTP; 17 Oct 2012 18:03:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+g5zkUvjOgE3j7BEvtjqKlbsOsMRwMxkQSb/1MAa
	7qJyZAtewc+d44
X-X-Sender: gene099@bonsai2
In-Reply-To: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207919>

Hi,

On Wed, 17 Oct 2012, Felipe Contreras wrote:

> I've looked at many hg<->git tools and none satisfy me. Too complicated,
> or too slow, or to difficult to setup, etc.

The one I merged into Git for Windows (since that is what I install on all
my machines even if they run Linux) is rock-solid. It also comes with
tests. And it requires a fix I tried to get into git.git (but failed,
since I was asked to do much more in addition to what I needed for myself,
and I lack the time to address such requests these days).

So I have to admit that I do not quite see the point of avoiding to
enhance the existing work of Sverre (and a little bit of me, too, in a
hackathon for which I traveled half the continent back in July 2011).

Ciao,
Johannes
