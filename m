From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/6] revert: allow mixing "pick" and "revert" actions
Date: Sun, 8 Jan 2012 15:55:10 -0600
Message-ID: <20120108215510.GS1942@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-5-git-send-email-artagnon@gmail.com>
 <20120108194014.GI1942@burratino>
 <CALkWK0mYbBsZN1UX9YM0VWQezZsBpJCcEgKirCggtNXs0HZ-8g@mail.gmail.com>
 <20120108214042.GR1942@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 22:50:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rk0d0-00089i-QF
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 22:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602Ab2AHVuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 16:50:04 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51985 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552Ab2AHVuD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 16:50:03 -0500
Received: by iaeh11 with SMTP id h11so5783988iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 13:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7NRbX4JOQsvqKgaB0Z94QJoXO+CCRIJoqdKoVs3XXqk=;
        b=s9toh4LHhzEzq4K0RNeo4fNn55NPwI7/C2Mg0PaPx0qTA2Xuz9FxNTpipDkGEBtkzU
         wnQ4BXLE2gDgaVDG7Ya3EsAjA6kzrFtBQjXJnAUXvCkidlybYgLH0SJXmdJhM9bXvZBr
         h95x/gCCQu6NlwSjI9PCcUPPEJNMFu2HGFu2g=
Received: by 10.50.193.229 with SMTP id hr5mr16354642igc.15.1326059403153;
        Sun, 08 Jan 2012 13:50:03 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 36sm242875767ibc.6.2012.01.08.13.50.02
        (version=SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 13:50:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120108214042.GR1942@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188144>

Jonathan Nieder wrote:

> I'll pick up
> this patch, play around with it and send separately.

On second thought, do you have a link to the last submitted version,
and do you remember if there were any important changes since then?
The base for that one should be closer to "master", I think.
