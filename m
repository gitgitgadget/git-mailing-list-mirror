From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/6] The move to sequencer.c
Date: Sun, 8 Jan 2012 13:28:53 -0600
Message-ID: <20120108192853.GE1942@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 20:24:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjyLb-0005E0-Ej
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 20:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493Ab2AHTXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 14:23:46 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34170 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab2AHTXp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 14:23:45 -0500
Received: by iaeh11 with SMTP id h11so5647361iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 11:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zBk0aHWxS8OLimTlQBZXYx/VUwLwUyRWBQVI3Z/1ugk=;
        b=p200aL3NDRzzwEbXWMGH+sJ5n2GVtp01uCS9OfMEv76jmXkz/Z6WtMaMp5T2WWd+uI
         c+3BovYCjT3lhu7W0FfEAa6A+7u3eGIKHgV9elKHgJm4dSeeFweOp+dzWX3Dj1AeqTJm
         HqLoQ6i09t9MOoUZFKLy1EO7zmVC2kLU8zy48=
Received: by 10.50.183.199 with SMTP id eo7mr16233058igc.5.1326050624882;
        Sun, 08 Jan 2012 11:23:44 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id yg2sm11696070igb.1.2012.01.08.11.23.44
        (version=SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 11:23:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188115>

(-cc: Junio)
Ramkumar Ramachandra wrote:

> I've tried a slightly different approach: the objective of the patches
> seem to be much clearer this time.

For the sake of new and forgetful readers: what is that objective?
