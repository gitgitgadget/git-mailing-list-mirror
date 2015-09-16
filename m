From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 0/2] notes: allow read only notes actions on refs outside
 of refs/notes
Date: Thu, 17 Sep 2015 07:36:02 +0900
Message-ID: <20150916223602.GA4197@glandium.org>
References: <1442441194-5506-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 01:01:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcLhr-0007RS-VV
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 01:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbbIPXBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 19:01:36 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:34711 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784AbbIPXBf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 19:01:35 -0400
X-Greylist: delayed 1520 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2015 19:01:34 EDT
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <glandium@glandium.org>)
	id 1ZcLJ4-0001HO-5f; Thu, 17 Sep 2015 07:36:02 +0900
Content-Disposition: inline
In-Reply-To: <1442441194-5506-1-git-send-email-jacob.e.keller@intel.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278087>

On Wed, Sep 16, 2015 at 03:06:32PM -0700, Jacob Keller wrote:
> This topic depends on mh/notes-allow-reading-treeish and actually
> expands what this topic allowed before. Previously, treeishes such as
> notes@{1} were made allowable, but the ref still had to be found under
> refs/notes.

I haven't found the time to finish that topic yet, but I haven't
forgotten it. Sorry about that.

Mike
