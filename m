From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: More gitweb queries..
Date: Mon, 30 May 2005 01:02:40 +0200
Message-ID: <20050529230240.GB12290@cip.informatik.uni-erlangen.de>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org> <20050527192941.GE7068@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505271248450.17402@ppc970.osdl.org> <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org> <20050527192941.GE7068@cip.informatik.uni-erlangen.de> <7vhdgoxx8c.fsf@assigned-by-dhcp.cox.net> <20050527195552.GA6541@cip.informatik.uni-erlangen.de> <7vu0kowho9.fsf@assigned-by-dhcp.cox.net> <20050527203227.GA11139@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UHN/qo2QbUvPLonB"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 01:04:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcWoX-0003ID-QX
	for gcvg-git@gmane.org; Mon, 30 May 2005 01:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVE2XFp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 19:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVE2XFp
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 19:05:45 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:53687 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261373AbVE2XCx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 19:02:53 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4TN2eS8000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 29 May 2005 23:02:40 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4TN2eP2000488;
	Mon, 30 May 2005 01:02:40 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050527203227.GA11139@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
here we go!  gitk screenshot:
http://wwwcip.informatik.uni-erlangen.de/~sithglan/shot.png (64k)

(faui00u) [~/work/mutt/git/mutt-test] ../../../git/yagf/git pull ../mutt-attach-file/ ../mutt-collapse-flags/ ../mutt-cstatus/ ../mutt-cvs/ ../mutt-edit-threads/ ../mutt-hcache/ ../mutt-headers/ ../mutt-imap/ ../mutt-maildir-mtime/ ../mutt-move-hook/ ../mutt-setenv-hack/ ../mutt-thread-pattern/ ../mutt-menu-move/
<chatty output>
(faui00u) [~/work/mutt/git/mutt-test] git treediff ../mutt-tg-solaris
(faui00u) [~/work/mutt/git/mutt-test] git changes -m | perl -pe '$a += /^diff-tree/; exit if $a==2'
diff-tree 5b22da9792b6f6a968dc0a916275d6c301575f75 (from e8f4a291a81f0a8fb24555f0e36e4b75e2d3f4c8)
Author: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Date:   Mon May 30 00:28:53 2005 +0200

    => faui00u:/home/cip/adm/sithglan/work/mutt/git/mutt-test
    <= /home/cip/adm/sithglan/work/mutt/git/mutt-test/../mutt-attach-file/.git (bringing head ahead)
    <= /home/cip/adm/sithglan/work/mutt/git/mutt-test/../mutt-collapse-flags/.git (automatic merge)
    <= /home/cip/adm/sithglan/work/mutt/git/mutt-test/../mutt-cstatus/.git (threeway merge)
    <= /home/cip/adm/sithglan/work/mutt/git/mutt-test/../mutt-cvs/.git (nothing to merge)
    <= /home/cip/adm/sithglan/work/mutt/git/mutt-test/../mutt-edit-threads/.git (threeway merge)
    <= /home/cip/adm/sithglan/work/mutt/git/mutt-test/../mutt-hcache/.git (threeway merge)
    <= /home/cip/adm/sithglan/work/mutt/git/mutt-test/../mutt-headers/.git (threeway merge)
    <= /home/cip/adm/sithglan/work/mutt/git/mutt-test/../mutt-imap/.git (automatic merge)
    <= /home/cip/adm/sithglan/work/mutt/git/mutt-test/../mutt-maildir-mtime/.git (threeway merge)
    <= /home/cip/adm/sithglan/work/mutt/git/mutt-test/../mutt-move-hook/.git (nothing to merge)
    <= /home/cip/adm/sithglan/work/mutt/git/mutt-test/../mutt-setenv-hack/.git (automatic merge)
    <= /home/cip/adm/sithglan/work/mutt/git/mutt-test/../mutt-thread-pattern/.git (threeway merge)
    <= /home/cip/adm/sithglan/work/mutt/git/mutt-test/../mutt-menu-move/.git (threeway merge)

Could please someone who has a clue how this merge should work (which it
hopefully already does) look at my code to check for obvious mistakes in
the merge *logic*.  I call 'merge' with all involved trees (with current
head first, if there is a current head). If everything is fine. I would
like to write a seperate git-resolve script in sh or adopt the current
to multi head merge - whatever you please.

sub
merge
{

	my $message      = undef;
	my $head         = undef;
	my $last_tree    = undef;
	my $fh;
	my @heads        = ();

	foreach my $r (@_) {
		my $current_head = @{$r}[0];
		my $current_url  = @{$r}[1];

		print "current_head => $current_head\ncurrent_url => $current_url\n";

		push(@heads, '-p', ${current_head});

		if (! defined($last_tree)) {
			$message    = "=> ${current_url}\n";
			$head       = $current_head;
			$last_tree  = $current_head;
			
			if (@_ == 1) {
				head($head);
				return;
			}

			next;
		}

		my $merge_base = gitcmdout('git-merge-base', $head, $current_head)
				 || die ("no merge-base");
		chomp($merge_base);

		print "head => $head\nremote => $current_head\nbase => $merge_base\n";
	
		if ($merge_base eq $current_head) {
			$message .= "<= ${current_url} (nothing to merge)\n";

			if (@_ == 2) {
				return;
			}

			next;
		}

		if ($merge_base eq $head) {
			$message   .= "<= ${current_url} (bringing head ahead)\n";
			$head       = ${current_head};
			$last_tree  = ${current_head};

			if (@_ == 2) {
				head($head);
				return;
			}

			next;
		}

		gitcmd('git-read-tree', '-m', $merge_base, $last_tree, $current_head);
		if (! defined($last_tree = write_tree())) {
			system('git-merge-cache', '-o', 'git-merge-one-file-script', '-a');
			if (! defined($last_tree = write_tree())) {
				# FIXME: Make manual intervention possible
				# --tg 23:11 05-05-29
				die("Couldn't merge automatically: Call 'git resolve'");
			}
			$message .= "<= ${current_url} (threeway merge)\n";

		} else {
			$message .= "<= ${current_url} (automatic merge)\n";
		}
	}

	open($fh, "+>", undef);
	print $fh $message;
	seek($fh, 0, 0);
	$head = gitcmdinout($fh, 'git-commit-tree', $last_tree, @heads);
	chomp($head);
	close $fh;

	head($head);
	return;
}

	Thomas

--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=git

#!/usr/bin/env perl

use strict;
use warnings;
use IO::Handle;
use File::Temp qw/ tempfile tempdir /;
use File::Copy;
use Cwd;
use Getopt::Long;

STDOUT->autoflush(1);

my $hostname = gitcmdout('hostname');
chomp($hostname);

my $DIFF  = undef;
my $PATCH = undef;

if (-x '/opt/csw/bin/gdiff') {
	$DIFF='/opt/csw/bin/gdiff';

} else {
	$DIFF='diff';
}

if (-x '/usr/bin/gpatch') {
	$PATCH='/usr/bin/gpatch';

} else {
	$PATCH='patch';
}

my %commands = (
	"add"        => \&add,
	"checkout"   => \&checkout,
	"ci"         => \&ci,
	"clone"      => \&clone,
	"commit"     => \&commit,
	"diff"       => \&diff,
	"treediff"   => \&treediff,
	"dirty"      => \&dirty,
	"help"       => \&usage,
	"init-db"    => \&init_db,
	"log"        => \&log,
	"orphan"     => \&orphan,
	"parent"     => \&parent,
	"patch"      => \&patch,
	"pull"       => \&pull,
	"push"       => \&_push,
	"refresh"    => \&refresh,
	"revert"     => \&revert,
	"rm"         => \&rm,
	"setup"      => \&setup,
	"status"     => \&status,
	"undo"       => \&undo,
	"changed"    => \&changed,
	"resolve"    => \&resolve,
	"changes"    => \&changes,
);

my %touched = ();

sub
usage
{
	print STDERR <<"__EOF__";
Usage: $0 COMMAND [ARG]...

Available commands:

__EOF__

	print "\t" . join("\n\t", sort(keys(%commands))) . "\n\n";

	return 1;
}

sub
refresh
{
	`git-update-cache --refresh`;
}

sub
process_git_diff_output
{
	my $str = shift || return (());

	my @in  = split("\0", $str);
	my @out = ();

	while (@in) {
		my @tmp = split(' ', shift(@in));
		$tmp[0] =~ s/^://g;
		push(@tmp, shift(@in));
		push(@out, [@tmp]);
	}

	return(@out);
}

sub
dirty_files
{
	refresh();

	my @dirty = ();
	my $str = gitcmdout('git-diff-files', '-z', '-r');

	foreach (process_git_diff_output($str)) {
		if ((@{$_})[1] ne '000000') {
			push(@dirty, @{$_}[5]);
		}
		#print "<" . join("> <", @{$_}) . ">\n";
	}

	return @dirty;
}

sub
orphan_files
{
	my @orphan = gitcmdout('git-ls-files', '--others');
	chomp(@orphan);

	my $regexp = '^\.';
	if (-f '.git/ignore') {
		my @ignore = ();
		chomp (@ignore = _read_file('.git/ignore'));
		$regexp = join('|', '^\.', @ignore);
	}

	@orphan = grep(! /$regexp/, @orphan);

	return @orphan;
}

sub
orphan
{
	foreach (orphan_files()) {
		print $_ . "\n";
	}
}

sub
dirty
{
	foreach (dirty_files()) {
		print $_ . "\n";
	}
}

sub
changed
{
	foreach my $rev (gitcmdout('git-rev-list', 'HEAD')) {
		chomp($rev);
		my %hash = commit_hash($rev);
		
		my $str = gitcmdout('git-diff-tree', '--root', '-r', '-z', $rev);
		foreach (process_git_diff_output($str)) {
			my ($time, $rest) = split(/\s/, $hash{committer_date});
			push(@{$touched{@{$_}[5]}}, $time);
		}
	}
}

sub
status
{
	my %hash = ();
	
	foreach (orphan_files()) {
		$hash{$_} = '?';
	}

	foreach (dirty_files()) {
		$hash{$_} = 'D';
	}

	my $str = gitcmdout('git-diff-cache', '-r', '--cached', '-z', 'HEAD');
	foreach (process_git_diff_output($str)) {
		if      (@{$_}[0] eq '000000') {
			$hash{@{$_}[5]} .= '+';

		} elsif (@{$_}[1] eq '000000') {
			$hash{@{$_}[5]} .= '-';

		} else {
			$hash{@{$_}[5]} .= '*';
		}
	}

	foreach (sort(keys(%hash))) {
		if ($hash{$_} eq "D") {
			$hash{$_} = "D ";
		}
		printf("% 2s %s\n", $hash{$_}, $_);
	}
}

sub
write_tree
{
	chomp (my $tree = `git-write-tree`);
	if ($?) {
		return undef;
	} else {
		return $tree;
	}
}

sub
retrieve_unmerged
{
	my %hash = ();
	
	foreach my $line (gitcmdout('git-ls-files', '--unmerged')) {
		chomp($line);
# 100644 cde27275fad8103084d7ed2d08d246ba4ce6eb9c 1 Makefile
# 100644 d311a35e5e8a09629ea9e6051a43710c76fa8f6d 2 Makefile
# 100644 ec2b76bf90fb105b2aaf00a66f44b135046d3002 3 Makefile
		if ($line =~ /^(\d{6})\s([a-z0-9]{40})\s(\d)\s(.+)$/) {
			push(@{$hash{$4}}, $line);
		} else {
			die("Can't match: <$line>\n");
		}
	}

	return %hash;
}

sub
process_unmerged_file
{
	my $line;
	my $file;
	my @files = ();
	while($line = shift) {
		if ($line =~ /^(\d{6})\s([a-z0-9]{40})\s(\d)\s(.+)$/) {
			if ($3 eq '1') { $file = "$4.GCA"; }
			if ($3 eq '2') { $file = "$4.LOCAL"; }
			if ($3 eq '3') { $file = "$4.REMOTE"; }

			my $mode = substr($1, 2);

			if (-f $file) {
				die("Please get rid of $file\n");
			}

			print STDERR "Checking out: $file with permissions $mode\n";

			system("git-cat-file blob $2 > $file");
			chmod oct($mode), $file;
			push(@files, $file);
		}
	}

	if (@files == 3) {
		my $filename = (@files)[0];
		$filename =~ s#\.(GCA|LOCAL|REMOTE)$##;

		print STDERR <<"EOF";

You got GCA, LOCAL and REMOTE, so I run merge for you and leaving the merges in
${filename} .\n

EOF

		unlink($filename);
		system('cp', "${filename}.LOCAL", "${filename}");

		system('merge', "${filename}", "${filename}.GCA", "${filename}.REMOTE");
	}

	print STDERR <<"EOF";

Please resolve the conflict and add the file using the command 'git ci file'.
Droping you to a login shell now. Please exit the shell as soon as you resolved
the conflict.

EOF

	system($ENV{'SHELL'}, '--login');

	foreach (@files) {
		unlink($_);
	}
}

sub
resolve
{
	if (! -f '.git/RESOLVE') {
		die("Nothing to resolve");
	}
	if ( ! -f '.git/HEAD' && ! -l '.git/HEAD') {
		die("How the hell I am supposed to resolve without a head?");
	}

	my $fh;
	my $head = head();
	my $merge_tree = undef;
	my $pwd        = getcwd;
	chomp (my ($remote_head, $url) = _read_file('.git/RESOLVE'));

	print "remote_head => $remote_head\nurl => $url\n";

	my %unmerged = retrieve_unmerged();

	foreach my $file (keys(%unmerged)) {
		process_unmerged_file(@{$unmerged{$file}});
	}

	if (! defined($merge_tree = write_tree())) {
		die("Still unresolved conflicts. Run git resolve again.");
	}

	open($fh, "+>", undef);
	print $fh "Manual Merge $url => ${hostname}:${pwd}\n";
	seek($fh, 0, 0);
	chomp($head = gitcmdinout($fh, 'git-commit-tree', $merge_tree, '-p', $head, '-p', $remote_head));
	close $fh;

	head($head);
	unlink('.git/RESOLVE');
	checkout('-f');

	print STDERR "All issues resolved manual: Commited as ${head}.\n";
        print STDERR "Have a pleasant day.\n";
	return;
}

sub
merge
{

	my $message      = undef;
	my $head         = undef;
	my $last_tree    = undef;
	my $fh;
	my @heads        = ();

	foreach my $r (@_) {
		my $current_head = @{$r}[0];
		my $current_url  = @{$r}[1];

		print "current_head => $current_head\ncurrent_url => $current_url\n";

		push(@heads, '-p', ${current_head});

		if (! defined($last_tree)) {
			$message    = "=> ${current_url}\n";
			$head       = $current_head;
			$last_tree  = $current_head;
			

			if (@_ == 1) {
				print "Setting HEAD\n";
				head($head);
				return;
			}

			print "Next round\n";

			next;
		}

		my $merge_base = gitcmdout('git-merge-base', $head, $current_head)
				 || die ("no merge-base");
		chomp($merge_base);

		print "head => $head\nremote => $current_head\nbase => $merge_base\n";
	
		if ($merge_base eq $current_head) {
			$message .= "<= ${current_url} (nothing to merge)\n";

			if (@_ == 2) {
				return;
			}

			next;
		}

		if ($merge_base eq $head) {
			$message   .= "<= ${current_url} (bringing head ahead)\n";
			$head       = ${current_head};
			$last_tree  = ${current_head};

			if (@_ == 2) {
				head($head);
				return;
			}

			next;
		}

		gitcmd('git-read-tree', '-m', $merge_base, $last_tree, $current_head);
		if (! defined($last_tree = write_tree())) {
			system('git-merge-cache', '-o', 'git-merge-one-file-script', '-a');
			if (! defined($last_tree = write_tree())) {
				# FIXME: Make manual intervention possible
				# --tg 23:11 05-05-29
				die("Couldn't merge automatically: Call 'git resolve'");
			}
			$message .= "<= ${current_url} (threeway merge)\n";

		} else {
			$message .= "<= ${current_url} (automatic merge)\n";
		}
	}

	open($fh, "+>", undef);
	print $fh $message;
	seek($fh, 0, 0);
	$head = gitcmdinout($fh, 'git-commit-tree', $last_tree, @heads);
	chomp($head);
	close $fh;

	head($head);
	return;
}

sub
patch
{
	my @files = ();
	my ($fh, $patch);
	my $file = shift || die("Need at least on argument.\n");
	my $head  = undef;
	my $dir   = undef;

	if (head()
	&& (    dirty_files()
            || `git-diff-cache -r --cached HEAD`)) {
		print STDERR "Get rid of dirty files / uncommited deltas first.\n";
		exit 1;
	}

	($fh, $patch) = tempfile(CLEANUP => 1);

	`filterdiff -x '*/.*' $file > $patch`;

	@files = `lsdiff --strip 1 $patch`;

	chomp(@files);

	$dir = tempdir(CLEANUP => 1);
	$ENV{GIT_INDEX_FILE} = "$dir/.index";

	if ($head = head()) {
		gitcmd('git-read-tree', $head);
		foreach my $file (@files) {
			gitcmd('git-checkout-cache', '-q', "--prefix=$dir/", $file);
		}
	}

	my $pwd = getcwd;

	symlink("$pwd/.git", "$dir/.git");

	chdir($dir);

	# FIXME call in batch modus and check return value --tg 08:30 05-05-21
	system("${PATCH} -p1 < $patch");

	foreach my $file (@files) {
		gitcmd('git-update-cache', '--add', '--remove', $file);
	}

	commit();

	chdir($pwd);
	delete($ENV{GIT_INDEX_FILE});
	checkout('-f');
}

sub
checkout
{
	my $head = head();
	gitcmd('git-read-tree', '-m', $head);

	# FIXME if this fails call it without -m --tg 20:25 05-05-09

	if (defined($_[0]) && $_[0] eq '-f') {
		gitcmd('git-checkout-cache', '-u', '-f', '-a');

	} else {
		gitcmd('git-checkout-cache', '-u', '-q', '-a');
	}

#	changed();
#
#	foreach my $file (gitcmdout('git-ls-files')) {
#		chomp($file);
#		my $time = (sort {$b <=> $a} @{$touched{$file}})[0];
#		utime $time, $time, $file;
#	}
}

sub
generate_url
{
	my $url = shift;

	if (! defined($url)) {
		if ( -f '.git/PARENT' || -l '.git/PARENT') {
			chomp ($url = _read_file('.git/PARENT'));
		} else {
			die("$0: No URL specified and no parent found: Where to pull from?\n");
		}
	} else {
		$url =~ s#\/$##;

		if (-d $url &&
		    ! ($url =~ /\.git$/)) {
				$url .= "/.git";
		}

		if (-d $url &&
		    ! ($url =~ /^\//)) {
			# FIXME: use Cwd; my $pwd = getcwd; --tg 21:32 05-05-03
			chomp(my $pwd = `pwd`);
			$url = "${pwd}/${url}";
		}
	}

	return $url;
}

sub
pull
{
	my @references = ();
	my %options;
	local @ARGV = @_;
	GetOptions(\%options, 'o', 'l');
	@_ = @ARGV;

	if (head()
	&& (! defined($options{'o'}))
	&& (    dirty_files()
	    || `git-diff-cache -r --cached HEAD`)) {
		print STDERR "Get rid of dirty files / uncommited deltas first.\n";
		exit 1;
	}

	# FIXME SANITY CHECK. It is only possible to pull in 15 trees
	# --tg 17:58 05-05-28

	if (! defined($_[0])) {
		unshift(@_, generate_url(shift));
	}

	if ( -f '.git/HEAD' || -l '.git/HEAD') {
		push(@references, [head(), "${hostname}:" . getcwd()]);
	}

	while(defined (my $url = shift)) {
		$url = generate_url($url);
		my $remote_head = undef;

		if (defined($options{'l'}) && -d $url) {
			$ENV{'GIT_ALTERNATE_OBJECT_DIRECTORIES'} = "${url}/objects";

		} else {
			gitcmd('rsync', '-qa', '--ignore-existing', "$url/objects/.", ".git/objects/.");
		}
		gitcmd('rsync', '-qL', "$url/HEAD", '.git/REMOTE_HEAD');
		chomp($remote_head = _read_file('.git/REMOTE_HEAD'));
		push(@references, [$remote_head, $url]);
	}

	if (! defined($options{'o'})) {
		merge(@references);
		checkout('-f');
	}
}

sub
changes
{
	my %options;
	local @ARGV = @_;
	GetOptions(\%options, "L", "R", "d", "m", "n", "t=s", "S=s", 'root');
	@_ = @ARGV;

	my $git_diff_tree_options = '-s';
	if (defined ($options{'d'})) {
		$git_diff_tree_options = '-p';
	}
	if (defined ($options{'m'})) {
		$git_diff_tree_options .= ' -m';
	}
	if (defined ($options{'S'})) {
		$git_diff_tree_options .= " -S'$options{'S'}'";
	}
	if (defined ($options{'root'})) {
		$git_diff_tree_options .= " --root";
	}

	if (defined ($options{'L'})) {
		if (! defined ($options{'n'})) {
			pull('-o', '-l', shift);
		}
		system("git-rev-tree HEAD '^REMOTE_HEAD' | sed -e 's/^[0-9]* //' | git-diff-tree --stdin -v $git_diff_tree_options " . join(' ', @ARGV));

	} elsif (defined ($options{'R'})) {
		if (! defined ($options{'n'})) {
			pull('-o', '-l', shift);
		}
		system("git-rev-tree REMOTE_HEAD '^HEAD' | sed -e 's/^[0-9]* //' | git-diff-tree --stdin -v $git_diff_tree_options " . join(' ', @ARGV));

	} elsif (defined ($options{'t'})) {
		system("git-rev-tree HEAD '^$options{'t'}' | sed -e 's/^[0-9]* //' | git-diff-tree --stdin -v $git_diff_tree_options " . join (' ', @ARGV));
	
	} else {
		system("git-rev-list HEAD | git-diff-tree --stdin -v $git_diff_tree_options " . join(' ', @ARGV));
	}
}

sub
_push
{
	my $url = generate_url(shift);

	gitcmd('rsync', '-qL', "$url/HEAD", '.git/REMOTE_HEAD');
	chomp (my $remote_head = _read_file('.git/REMOTE_HEAD'));
	my $head        = head() || die("No local HEAD\n");
	if ($head eq $remote_head) {
		print STDERR "Nothing to push.\n";
		return;
	}
	print "head => $head\nremote => $remote_head\n";
	my @revlist     = gitcmdout('git-rev-list', $head);
	if (! grep(/^${remote_head}$/, @revlist)) {
		print STDERR "Remote is ahead or unrelated: Need to pull first?\n";
		exit 1;
	}
	gitcmd('rsync', '-qa', '--ignore-existing', ".git/objects/.", "$url/objects/.");
	gitcmd('rsync', '-q', '.git/HEAD', "$url/HEAD");
}

sub
clone
{
	my %options;

	GetOptions(\%options, "l");

	my $url     = shift(@ARGV);
	my $project = shift(@ARGV);

	if (! defined($url) || ! defined($project)) {
		die("Usage: $0 clone <url> <project>\n");
	}

	$url = generate_url($url);

	if (defined($options{l})) {
		if (-d $url) {
			-d ".git"              && die("$0 clone $project: Don\'t create repository in a repository.");
			mkdir($project, 0755)  || die("$0 clone $project: mkdir: $!");
			chdir($project)        || die("$0 clone $project: chdir: $!");
			mkdir('.git', 0755)    || die("$0 clone $project: mkdir: $!");
			symlink("$url/objects", '.git/objects') || die("Can\'t symlink object database");

		} else {
			die("Can't symlink from network repositories\n");
		}
	} else {
		setup($project);
	}
	parent($url);
	pull();
}

sub
parent
{
	my $parent = $_[0];
	if (defined($parent)) {
		if ($parent eq "-c") {
			if ( -f ".git/PARENT" || -l ".git/PARENT") {
				unlink(".git/PARENT") || die("can't delete .git/PARENT: $!");
			}
			print STDERR "$0 parent: Parent removed\n";

		} else {
			$parent = generate_url($parent);

			_write_file('.git/PARENT', "$parent\n");
		}

	} else {
		if ( -f ".git/PARENT" || -l ".git/PARENT") {
			
			chomp($parent = _read_file('.git/PARENT'));
			print "${parent}\n";

		} else {
			print STDERR "$0 parent: No parent specified\n";
		}
	}
}

sub
diff
{
	my %options;
	local @ARGV = @_;
	GetOptions(\%options, 'r=s', 'f', 'c', 'v', "S=s", 'root');
	@_ = @ARGV;

	my $dir = tempdir(CLEANUP => 1);

	refresh();

	my $git_diff_tree_options = '';

	if (defined ($options{'S'})) {
		$git_diff_tree_options .= " -S'$options{'S'}'";
	}

	if (defined ($options{'root'})) {
		$git_diff_tree_options .= " --root";
	}

	if (defined($options{'r'})) {
		if($options{'r'} =~ /:/) {
			my ($first, $second) = split(/:/, $options{'r'});
			system("git-diff-tree -p -r $first $second $git_diff_tree_options " . join(' ', @_));

		} else {
			if (defined ($options{'v'})) {
				$git_diff_tree_options .= ' -v';
			}
			system("git-diff-tree -p -r $options{'r'} $git_diff_tree_options " . join(' ', @_));
		}

	} elsif (defined($options{"f"})) {
		system("git-diff-files -r -z $git_diff_tree_options " . join(' ', @_) . " | git-diff-helper -z");

	} elsif (defined($options{"c"})) {
		system("git-diff-cache --cached -r -z HEAD $git_diff_tree_options " . join(' ', @_) . " | git-diff-helper -z");

	} else {
		system("git-diff-cache -r -z HEAD $git_diff_tree_options " . join(' ', @_) . " | git-diff-helper -z");
	}
}

sub
treediff
{
	my %options;
	local @ARGV = @_;
	Getopt::Long::Configure("pass_through");
	GetOptions(\%options, 'p=s');
	Getopt::Long::Configure("no_pass_through");
	@_ = @ARGV;
	pull('-o', '-l', $options{'p'});
	diff('-r', 'REMOTE_HEAD:HEAD', @_);
}

sub
init_db
{
	gitcmd( 'init-db', @_ );
}

sub
setup
{
	my $project = shift    || die ("usage: $0 setup project");
	-d ".git"              && die ("$0 setup $project: Don\'t create repository in a repository.");
	mkdir($project, 0755)  || die ("$0 setup $project: mkdir: $!");
	chdir($project)        || die ("$0 setup $project: chdir: $!");
	gitcmd('git-init-db');
}

sub
revert
{
	# TODO handle revert of add/remove --tg 02:32 05-05-06
	my @in    = ();
	my $fh;

	if (! defined($_[0])) {
		return;
	}

	if ($_[0] eq "-") {
		@in = <STDIN>;

	} else {
		@in = @_;
	}

	my $head = head();
	($fh, $ENV{GIT_INDEX_FILE}) = tempfile(CLEANUP => 1);
	gitcmd('git-read-tree', $head);

	foreach (@in) {
		chomp($_);
		$_ =~ s#^\.\/##;

		if (/^\./) {
			print STDERR "Warning: Skipping $_\n";
			next;
		}

		if (-d $_) {
			next;
		}

		gitcmd('git-checkout-cache', '-f', $_);
	}

	delete($ENV{GIT_INDEX_FILE});

	foreach (@in) {
		chomp($_);
		$_ =~ s#^\.\/##;

		if (/^\./) {
			next;
		}

		if (! -f $_) {
			next;
		}

		gitcmd('git-update-cache',  $_);
	}
}

sub
add
{
	my @in    = ();

	if (defined($_[0]) && $_[0] eq "-") {
		@in = <STDIN>;

	} else {
		@in = @_;
	}

	foreach (@in) {
		chomp($_);
		$_ =~ s#^\.\/##;

		if (/^\./) {
			print STDERR "Warning: Skipping $_\n";
			next;
		}

		if (-d $_) {
			next;
		}

		if (! -f $_) {
			print STDERR "Warning: Skipping nonexisting file: $_\n";
			next;
		}

		gitcmd( 'git-update-cache', '--add', '--', $_ );
	}

}

sub
ci
{
	my @in    = ();

	if (defined($_[0]) && $_[0] eq "-") {
		@in = <STDIN>;

	} else {
		@in = @_;
	}

	foreach (@in) {
		chomp($_);
		$_ =~ s#^\.\/##;

		if (/^\./) {
			print STDERR "Warning: Skipping $_\n";
			next;
		}

		if (-d $_) {
			next;
		}

		if (! -f $_) {
			print STDERR "Warning: Skipping nonexisting file: $_\n";
			next;
		}

		gitcmd( 'git-update-cache', '--', $_ );
	}

}

sub
rm
{
	my @in    = ();

	if (defined($_[0]) && $_[0] eq "-") {
		@in = <STDIN>;

	} else {
		@in = @_;
	}

	foreach (@in) {
		chomp($_);
		$_ =~ s#^\.\/##;

		if (/^\./) {
			print STDERR "Warning: Skipping $_\n";
			next;
		}

		if (-d $_) {
			next;
		}

		if (-f $_) {
			unlink($_) || die ("$0 rm $_: $!");
		}

		gitcmd( 'git-update-cache', '--remove', '--' , $_ );
	}

}

sub
head
{
	my $head = $_[0];
	if (defined($head)) {
		if ($head eq "") {
			if ( -f ".git/HEAD" || -l ".git/HEAD") {
				unlink(".git/HEAD") || die "failed to delete .git/HEAD: $!\n";
			}
		} else {
			chomp($head);
			_write_file( '.git/HEAD', "$head\n" );
		}

	} else {
		if (-f '.git/HEAD') {
			chomp( $head = _read_file( '.git/HEAD' ) );
		} else {
			$head = undef;
		}
	}

	return $head;
}

sub
print_commit
{
	my $commit = shift || die("need commit");

	print "commit $commit\n";
	foreach (gitcmdout('git-cat-file', 'commit', $commit)) {
		if (/^(author|committer)(.+>\s)(\d+)\s([+-]?\d{4})$/) {
			# local $ENV{TZ} = $4;
			print "$1$2" . localtime($3) . "\n";
		} else {
			print "$_\n";
		}
	}
	print "\n";
}

sub
commit
{
	my $head = head();
	chomp (my $tree = gitcmdout('git-write-tree'));

	if (dirty_files()) {
		die "$0 commit: Get rid of dirty files first.\n";
	}

	if (defined($head)) {
		my %hash = commit_hash($head);

		if ($hash{tree} eq $tree) {
			die "$0 commit: The commit wouldn't commit anything different.\n";
		}

		$head = gitcmdout('git-commit-tree', $tree, '-p', $head);
	} else {
		$head = gitcmdout('git-commit-tree', $tree);
	}

	head($head);
}

sub
log
{
	my $head = head() || return ;

	my $pid;
	if ( ! -p STDIN && ! -p STDOUT ) {
		my ( $r, $w );
		pipe( $r, $w ) || die "Failed to pipe: $!";
		defined( $pid = fork ) || die "Failed to fork: $!";
		if ( $pid ) { # Parent
			$SIG{INT} = $SIG{TERM} = $SIG{HUP} = sub {
				kill 15, $pid;
				exit 1;
			};
			close $r;
			close STDOUT;
			open STDOUT, '>&', $w || die "Failed to redirect STDOUT: $!";
		} else { # pager child
			close $w;
			close STDIN;
			open STDIN, '<&', $r || die "Failed to redirect STDIN: $!";
			if ( $ENV{PAGER} ) {
				exec( $ENV{PAGER} );
			} else {
				exec( 'less', '-r', '-' );
			}
		}
	}

	foreach (gitcmdout('git-rev-list', $head)) {
		print_commit($_);
	}

	if ( $pid ) {
		close STDOUT;
		waitpid($pid, 0);
	}
}

sub
commit_hash
{
	my %hash    = ();
	my $id      = shift || die ("$0: commit_hash: expect one argument");
	my $comment = 0;

 	my @lines = gitcmdout('git-cat-file', 'commit', $id);

	foreach (@lines) {
		chomp;

		if ($comment) {
			push(@{$hash{comment}}, $_);
			next;
		}

		if (/^tree\s(\w{40})$/) {
			$hash{tree} = $1;
			next;
		}

		if (/^parent\s(\w{40})$/) {
			push(@{$hash{parent}}, $1);
			next;
		}

		if (/^author\s(.*)\s<(.*)>\s(.*)$/) {
			$hash{author_name}  = $1;
			$hash{author_eMail} = $2;
			$hash{author_date}  = $3;
			next;
		}

		if (/^committer\s(.*)\s<(.*)>\s(.*)$/) {
			$hash{committer_name}  = $1;
			$hash{committer_eMail} = $2;
			$hash{committer_date}  = $3;
			next;
		}

		if (/^$/) {
			$comment = 1;
		}
	}

	return(%hash);
}

sub
first_parent
{
	my $this = shift || die ("$0: parent called without object");
	my %hash = commit_hash($this);

	if (! defined(@{$hash{parent}}[0])) {
		return "";
	}

	return(@{$hash{parent}}[0]);
}

sub
undo
{
	my $head = head();

	if (! defined($head)) {
		return;
	}

	if (    dirty_files()
            || `git-diff-cache -r --cached HEAD`) {
		print STDERR "Get rid of dirty files / uncommited deltas first.\n";
		exit 1;
	}

	my $newhead = first_parent($head);

	print "oldhead $head\nnewhead $newhead\n";

	head($newhead);
	checkout('-f');
}

sub
object_type
{
	my $id = shift;
	defined $id && $id =~ /^[A-Za-z0-9]{40}$/ ||
		die "Invalid sha1 id '$id'";
	my $type = gitcmdout('git-cat-file', '-t', $id );
	chomp $type;
	return $type;
}

sub
tree_id
{
	my $id = shift;
	( $id ) = grep { defined }
		map { /^tree ([A-Za-z0-9]{40})$/ ? $1 : undef }
			gitcmdout( 'git-cat-file', 'commit', $id ) or
		die "Unable to find tree id for commit id $id";
	object_type( $id ) eq 'tree' ||
		die "tree id from commit is not a tree object!";
	return $id;
}

sub
parent_id
{
	my $id = shift;
	my ( $pid ) = grep { defined }
		map { /^parent ([A-Za-z0-9]{40})$/ ? $1 : undef }
			gitcmdout( 'git-cat-file', 'commit', $id ) or
		die "Unable to determine parent commit of commit $id";
	return $pid;
}

# int
# main(int argc, char **argv)
# {

if (defined($ARGV[0]) && defined($commands{$ARGV[0]})) {
	my $string = shift;
	if ( ! -d ".git"
	&&   ! ($string eq "setup"
             || $string eq "init-db"
             || $string eq "clone")) {
		die("$0 $string: Not in a git BASE directory");
	}
	$commands{$string}->(@ARGV);

} else {
	if (defined($ARGV[0])) {
		print STDERR "No such command: $ARGV[0]\n\n";
	}	
	usage();
}

# }

{
	my %gitcmd;

	sub
	gitcmdpath
	{
		my $cmd = shift;
		unless ( defined $gitcmd{$cmd} ) {
			local $/ = "\n";
			chomp( $gitcmd{$cmd} = `which $cmd` );
			return undef if $gitcmd{$cmd} eq '';
		}
		return $gitcmd{$cmd};
	}

	sub
	gitcmd
	{
		my $cmd = shift;
		gitcmdpath( $cmd ) || die "command '$cmd' not found";
		my $r = system( $gitcmd{$cmd}, @_ );
		die "$cmd failed: " . _gitcmderrmsg( $cmd )
			if $r != 0;
		return 1;
	}

	sub
	gitcmdinout
	{
		my $infh = shift;
		my $cmd  = shift;
		gitcmdpath( $cmd ) || die "command '$cmd' not found";
		my ( $r, $w );
		pipe( $r, $w ) || die "Failed to pipe: $!";
		my $pid = fork();
		die "Failed to fork: $!" unless defined $pid;
		if ( $pid ) {
			close $w;
			local $/;
			local $_ = <$r>;
			close $r;
			my $kid = waitpid( $pid, 0 );
			die "Hmm, auto reaping in place?" if $kid == -1;
			die "$cmd failed: " . _gitcmderrmsg( $cmd )
				if $? & 127 || $? >> 8 != 0;
			if ( wantarray ) {
				return split( "\n", $_ );
			} else {
				return $_;
			}
		} else {
			close $r;
			close STDOUT;
			close STDIN;
			open STDIN, '<&', $infh || die "Failed to rediret STDIN";
			open STDOUT, '>&', $w || die "Failed to redirect STDOUT";
			exec( $gitcmd{$cmd}, @_ );
		}
	}

	sub
	gitcmdout
	{
		my $cmd = shift;
		gitcmdpath( $cmd ) || die "command '$cmd' not found";
		my ( $r, $w );
		pipe( $r, $w ) || die "Failed to pipe: $!";
		my $pid = fork();
		die "Failed to fork: $!" unless defined $pid;
		if ( $pid ) {
			close $w;
			local $/;
			my $ret = <$r>;
			close $r;

			my $kid = waitpid( $pid, 0 );
			die "Hmm, auto reaping in place?" if $kid == -1;
			die "$cmd failed: " . _gitcmderrmsg( $cmd )
				if $? & 127 || $? >> 8 != 0;

			if (wantarray) {
				return split("\n", $ret);
			} else {
				return $ret;
			}
		} else {
			close $r;
			close STDOUT;
			open STDOUT, '>&', $w || die "Failed to redirect STDOUT";
			exec( $gitcmd{$cmd}, @_ );
		}
	}

	sub
	_gitcmderrmsg
	{
		my $cmd = shift;
		my $e;
		if ( $? == -1 ) {
			$e = "failed to execute $gitcmd{$cmd}: $!";
		} elsif ( $? & 127 ) {
			$e = sprintf( 'child die from signal %d', ( $? & 127 ) );
			$e .= ' (with coredump)' if $? & 128;
		} else {
			$e = sprintf( 'child exit value: %d', $? >> 8 );
		}
		return $e;
	}
}

sub
_recur_mkdir
{
	my $dir = shift;
	my @dir = split( /\//, $dir );
	my $path = '';
	while ( @dir ) {
		$path .= '/' . shift @dir;
		( -d $path ) || mkdir( $path ) ||
			die "Failed to mkdir $path: $!";
	}
}

sub
_read_file
{
	my $file = shift;
	my $fh;
	open $fh, '<', $file || die "failed to read $file: $!\n";
	if ( wantarray ) {
		my @r = <$fh>;
		close $fh || die "failed to close $file: $!\n";
		return @r;
	} else {
		local $/;
		my $r = <$fh>;
		close $fh || die "failed to close $file: $!\n";
		return $r;
	}
}

sub
_write_file
{
	my $file = shift;
	my $fh;
	open $fh, '>', $file || die "failed to write $file: $!\n";
	if ( @_ ) {
		print $fh join( $/, @_ );
	}
	close $fh            || die "failed to close $file: $!\n";
	return 1;
}

# vim:set noexpandtab:

--UHN/qo2QbUvPLonB--
