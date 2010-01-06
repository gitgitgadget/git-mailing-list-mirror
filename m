From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: cmake, was Re: submodules' shortcomings
Date: Wed, 6 Jan 2010 02:17:45 +0100
Message-ID: <3af572ac1001051717u7757f0dep9392fbb7b02cbbca@mail.gmail.com>
References: <4B3F6742.6060402@web.de>
	 <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de>
	 <4B421F90.4090402@web.de>
	 <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de>
	 <3af572ac1001051238t63e07a25hf9dd77056b79be89@mail.gmail.com>
	 <alpine.DEB.1.00.1001060005010.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 06 02:17:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSKX2-0001Py-2m
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 02:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899Ab0AFBRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 20:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754622Ab0AFBRr
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 20:17:47 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:52017 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096Ab0AFBRr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 20:17:47 -0500
Received: by pxi4 with SMTP id 4so12589222pxi.33
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 17:17:46 -0800 (PST)
Received: by 10.141.101.13 with SMTP id d13mr17082093rvm.120.1262740666568; 
	Tue, 05 Jan 2010 17:17:46 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1001060005010.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136233>

On Wed, Jan 6, 2010 at 12:06 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 5 Jan 2010, Pau Garcia i Quiles wrote:
>
>> For instance, I'd like to have a 'cmake' repository where I store all
>> the FindBlah.cmake modules, so that I can share them from every
>> repository, and not worry about users changing and committing in the
>> main project instead of the submodule.
>
> ... which reminds me... it was you who wanted to provide a working recipe
> to compile and install CMake on msysGit, right?

Right

> What happened in the meantime?

What happened is I was very busy until November. Now I've got some free time.

At this moment, what stops me from beginning this project is a simple
question: is it worth my time? From the discussion a few months ago,
it looked like it would the a second-class citizen and never replace
the existing buildsystems, so I really wonder if I should spend me
time porting git to CMake, or I should focus on other projects which
would gladly receive my contributions. If you honestly think it's
worth it, just tell me and I'll start the port to CMake immediately.

-- 
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
